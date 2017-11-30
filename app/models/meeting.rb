class Meeting < ApplicationRecord
  belongs_to :request
  has_many :users, through: :request

  validates :room_name, presence: true

end
