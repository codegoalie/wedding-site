class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :guest_id
      t.string :name
      t.integer :meal_id

      t.timestamps
    end
  end
end
