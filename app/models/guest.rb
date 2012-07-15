class Guest < ActiveRecord::Base
  has_many :attendees
  has_one :invitation

  attr_accessible :name, :email, :address, :city, :state, :zip, :count, :and_guest, :friendly_name

  def full_friendly_name
    full_name = self.friendly_name || self.name
    full_name << " and Guest" if self.and_guest

    full_name
  end

  def full_name
    full_name = self.name
    full_name << " and Guest" if self.and_guest

    full_name
  end
end
