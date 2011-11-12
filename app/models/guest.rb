class Guest < ActiveRecord::Base
  attr_accessible :name, :email, :address, :city, :state, :zip, :count
end
