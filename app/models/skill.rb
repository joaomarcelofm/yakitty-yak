class Skill < ApplicationRecord
  # has_many :user_skills
  # has_many :users, through: :user_skills
  has_and_belongs_to_many :users, join_table: :user_skills

end
