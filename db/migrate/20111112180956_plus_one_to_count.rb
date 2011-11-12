class PlusOneToCount < ActiveRecord::Migration
  def self.up
    change_table :guests do |t|
      t.remove :plus_one
      t.integer :count
    end
  end

  def self.down
    change_table :guests do |t|
      t.remove :count
      t.boolean :plus_one
    end
  end
end
