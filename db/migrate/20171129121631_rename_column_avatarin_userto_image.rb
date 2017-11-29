class RenameColumnAvatarinUsertoImage < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :avatar, :image
  end
end
