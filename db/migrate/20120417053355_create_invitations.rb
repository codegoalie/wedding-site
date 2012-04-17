class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :guest_id
      t.string :passcode

      t.timestamps
    end
  end
end
