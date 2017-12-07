class AddColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :onboarded, :boolean, default: false
  end
end
