class AddFriendlyNameToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :friendly_name, :string
    add_column :guests, :and_guest, :boolean, :default => false
  end
end
