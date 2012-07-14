class AddTableNumberToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :table_number, :integer
  end
end
