class Guest < ActiveRecord::Base
  has_many :attendees

  attr_accessible :name, :email, :address, :city, :state, :zip, :count
end
