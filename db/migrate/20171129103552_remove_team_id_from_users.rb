class RemoveTeamIdFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :team_id, :string
  end
end
