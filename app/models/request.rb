class Request < ApplicationRecord
  belongs_to :user
  belongs_to :receiver, class_name: "User"
  serialize :matches

  after_create :create_meeting, :slack_request

  def set_reciever
    User.find()
  end

  def create_meeting
     Meeting.create(room_name: 'demo', request: self)
  end

  def slack_request
    client = Slack::Web::Client.new
    client.chat_postMessage(
      channel: receiver.uid,
      text: "Hello #{receiver.name} :wave: :speech_balloon:!",
      username: "Yakitty-Yak",
      attachments: [
            {
                fallback: "XYZ",
                pretext: "Incoming from _Yakitty-Yak_ ",
                title: "Chat Request",
                title_link: "http://localhost:3000/meetings/#{Meeting.last.id}",
                text: "You have received a new request from #{user.name}. Because '#{Request.last.skill}' is a skill of yours, they would like to discuss '#{Request.last.topic}' with you.  \nThey have requested to meet at #{Request.last.start_time.strftime("%a, %d %b")}.",
                color: "#38B684",
                actions: [
                {
                    "name": "accept",
                    "text": "Accept",
                    "style": "primary",
                    "type": "button",
                    "value": "accept"
                },
                {
                    "name": "reject",
                    "text": "Reject",
                    "style": "danger",
                    "type": "button",
                    "value": "reject"
                }
            ]

            }
        ].to_json
        )
  end
end

