class AddRequestToMeeting < ActiveRecord::Migration[5.1]
  def change
    add_reference :meetings, :request, foreign_key: true
  end
end
