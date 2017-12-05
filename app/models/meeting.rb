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
      text: "Hello #{request.user.name} :wave:",
      username: "Yakitty-Yak",
      footer: "YakittyYak API",
      as_user: "false",
      attachments: [
        {
          title: "Get ready to start your meeting with #{request.receiver.name}",
          text: "Here is your meeting link: #{link} \n Have a great time! :yakitty-avatar:",
          color: "#38B684"
          }
        ]
    )

    client.chat_postMessage(
      channel: request.receiver.uid,
      text: "Hello #{request.receiver.name} :wave:",
      username: "Yakitty-Yak",
      footer: "YakittyYak API",
      as_user: "false",
      attachments: [
        {
          title: "Get ready to start your meeting with #{request.user.name}",
          text: "Here is your meeting link: #{link} \n Thanks for being an awesome community member!:yakitty-avatar:",
          color: "#38B684"
          }
        ]
    )
  end
end
