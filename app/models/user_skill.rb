class UserSkill < ApplicationRecord
  belongs_to :user_id
  belongs_to :skill_id
end
