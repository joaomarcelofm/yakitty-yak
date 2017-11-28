class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :user_meetings
  has_many :meetings, through: :user_meetings
  has_many :user_interests
  has_many :interests, through: :user_interests
  has_many :user_skills
  has_many :skills, through: :user_skills
end
