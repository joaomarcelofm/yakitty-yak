class Meeting < ApplicationRecord
  belongs_to :request
  has_many :users, through: :requests
  after_create :send_slack_meeting

  validates :room_name, presence: true

  def link
    # if Rails.env.production?
      "https://www.yakitty-yak.world/meetings/#{id}"
    # else
    #   "http://localhost:3000/meetings/#{id}"
    # end
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
          color: "#7FD0DF"
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
          color: "#7FD0DF"
          }
        ]
    )
  end

  def random_topic
    icebreaker = [ "🌽 If you were a vegetable, what vegetable would you be?",
      "🦁 If you woke up tomorrow as an animal, what animal would you choose to be and why?",
      "🌍 If you could live anywhere on this planet and take everything that you love with you, where would you choose to live?",
      "🌈 What favorite color are you and how does being that color make you feel?",
      "👻 If you could choose an imaginary friend, who would you choose and why?",
      "👯 If you could sit on a bench in a beautiful woods, who would you like sitting next to you on the bench and why?",
      "🌜 Are you sunrise, daylight, twilight, or night? Please share why you picked your time of day?",
      "📽 If you could be in the movie of your choice, what movie would you choose and what character would you play?"]

    icebreaker.sample
  end
end
