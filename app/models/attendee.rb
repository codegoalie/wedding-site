class Attendee < ActiveRecord::Base
  belongs_to :meal
  belongs_to :invitation

  attr_accessible :name, :meal_id, :invitation_id

  delegate :title, to: :meal, prefix: true, allow_nil: true
  delegate :guest_name, to: :invitation, allow_nil: true

end
