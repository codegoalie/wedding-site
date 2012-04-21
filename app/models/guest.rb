class Guest < ActiveRecord::Base
  has_many :attendees
  has_one :invitation

  attr_accessible :name, :email, :address, :city, :state, :zip, :count
end
