class CreateBudgetTable < ActiveRecord::Migration
  def self.up
    create_table :budget_items do |t|
      t.string :type
      t.decimal :units
      t.decimal :rate
      t.string :title
      t.date :balance_due_on
    end

  end

  def self.down
    drop_table :budget_items
  end
end
