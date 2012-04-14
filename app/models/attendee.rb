class Attendee < ActiveRecord::Base
  belongs_to :meal
  attr_accessor :name, :meal
end
