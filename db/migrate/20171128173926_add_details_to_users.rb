class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :user_uid, :integer
    add_column :users, :team_id, :integer
  end
end
