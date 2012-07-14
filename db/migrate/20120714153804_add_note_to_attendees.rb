class AddNoteToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :note, :string
  end
end
