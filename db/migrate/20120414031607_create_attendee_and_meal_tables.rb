class CreateAttendeeAndMealTables < ActiveRecord::Migration
  def self.up
    create_table :attendees do |t|
      t.integer :guest_id
      t.string :name
      t.integer :meal_id
    end

    create_table :meals do |t|
      t.string :title
      t.string :description
    end
  end

  def self.down
   #drop_table :attendees
   #drop_table :meals
  end
end
