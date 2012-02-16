class CreatePaymentsTable < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.decimal :amount, :null => false
      t.integer :check_number
      t.date    :paid_on
      t.integer :budget_item_id
    end
  end

  def self.down
    drop_table :payments
  end
end
