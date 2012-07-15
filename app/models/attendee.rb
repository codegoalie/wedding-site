class Attendee < ActiveRecord::Base
  belongs_to :meal
  belongs_to :invitation

  attr_accessible :name, :meal_id, :invitation_id, :note, :table_number

  delegate :title, to: :meal, prefix: true, allow_nil: true
  delegate :guest_name, to: :invitation, allow_nil: true
  delegate :guest_full_name, to: :invitation, allow_nil: true
  delegate :guest_friendly_name, to: :invitation, allow_nil: true
  delegate :guest_full_friendly_name, to: :invitation, allow_nil: true
  delegate :guest, to: :invitation, allow_nil: true


  def self.table_numbers
    Attendee.order(:table_number).uniq.pluck(:table_number)
  end

  def self.guests_by_table
    self.table_numbers.map do |i|
      next unless i
      [ i,
      Attendee.select('distinct invitation_id').where(table_number: i).map do |a| 
        a.table_plaque_name(i)
      end
      ]
    end.compact
  end
  

  def table_plaque_name(table_number)
    if Attendee.where(table_number: table_number, invitation_id: invitation_id).count == guest.count
      guest_full_name
    else
      names = Attendee.where(table_number: table_number, invitation_id: invitation_id).map(&:name)
      if names.count > 1
        "#{names[0..-2].join(', ')} & #{names.last}"
      else
        names.first
      end
    end
  end
end
