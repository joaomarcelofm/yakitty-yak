class Skill < ApplicationRecord
  has_many :user_skills
  has_many :users, through: :user_skills


  def self.skill_match(skillname)
    skill = Skill.find_by(name: skillname)
    user_list = skill.users
    return user_list
  end
end
