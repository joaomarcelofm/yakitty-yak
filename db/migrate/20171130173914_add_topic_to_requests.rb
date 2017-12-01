class AddTopicToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :topic, :string
  end
end
