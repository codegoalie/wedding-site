class Attendee < ActiveRecord::Base
  belongs_to :meal
  belongs_to :guest

  attr_accessible :name, :meal_id, :guest_id
end
