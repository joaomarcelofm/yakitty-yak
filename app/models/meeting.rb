class Meeting < ApplicationRecord
  has_many :user_meetings
  has_many :users, through: :user_meetings

  validates :room_name, presence: true

end
