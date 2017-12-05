class Meeting < ApplicationRecord
  belongs_to :request
  has_many :users, through: :requests
  after_create :send_slack_meeting

  validates :room_name, presence: true

  def link
    if Rails.env.production?
      "https://www.yakitty-yak.world/meetings/#{id}"
    elsif Rails.env.development?
      "http://localhost:3000/meetings/#{id}"
    end
  end


  def send_slack_meeting
    client = Slack::Web::Client.new
    client.chat_postMessage(
      channel: request.user.uid,
      text: "Hello #{request.user.name} :wave:, Here is your meeting link: #{link}",
      username: "Yakitty-Yak"
    )

    client.chat_postMessage(
      channel: request.receiver.uid,
      text: "Hello #{request.receiver.name} :wave:, Here is your meeting link: #{link}",
      username: "Yakitty-Yak"
    )
  end
end
