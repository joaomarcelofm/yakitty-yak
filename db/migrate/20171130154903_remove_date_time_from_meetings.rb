class RemoveDateTimeFromMeetings < ActiveRecord::Migration[5.1]
  def change
    remove_column :meetings, :date, :date
    remove_column :meetings, :time, :time
  end
end
