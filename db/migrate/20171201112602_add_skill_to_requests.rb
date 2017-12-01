class AddSkillToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :skill, :string
  end
end
