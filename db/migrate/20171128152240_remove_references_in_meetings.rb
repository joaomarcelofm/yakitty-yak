class RemoveReferencesInMeetings < ActiveRecord::Migration[5.1]
  def change
    remove_reference :meetings, :user_one
    remove_reference :meetings, :user_two
    add_column :meetings, :room_name, :string
  end
end
