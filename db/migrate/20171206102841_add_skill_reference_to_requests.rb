class AddSkillReferenceToRequests < ActiveRecord::Migration[5.1]
  def change
    remove_column :requests, :skill, :string
    add_reference :requests, :skill, foreign_key: true
  end
end
