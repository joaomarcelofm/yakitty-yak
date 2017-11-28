class CreateUserSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :user_skills do |t|
      t.references :user_id, foreign_key: true
      t.references :skill_id, foreign_key: true

      t.timestamps
    end
  end
end
