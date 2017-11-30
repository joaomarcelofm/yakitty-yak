class RemoveLevelFromSkills < ActiveRecord::Migration[5.1]
  def change
    remove_column :skills, :level, :integer
  end
end
