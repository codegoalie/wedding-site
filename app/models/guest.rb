class Guest < ActiveRecord::Base
  has_many :attendees
  has_one :invitation

  attr_accessible :name, :email, :address, :city, :state, :zip, :count, :and_guest, :friendly_name

  def full_friendly_name
    full_name = @friendly_name || @name
    full_name << " and Guest" if @and_guest
  end
end
