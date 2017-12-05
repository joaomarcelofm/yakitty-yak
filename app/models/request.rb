class Request < ApplicationRecord
  belongs_to :user
  belongs_to :receiver, class_name: "User"
  has_one :meeting
  serialize :matches

  after_create :slack_request

  def set_reciever
    User.find()
  end

  # def create_meeting
  #    Meeting.create(room_name: 'demo', request: self)
  # end

  def slack_request
    client = Slack::Web::Client.new
    if Rails.env.production?
      client.chat_postMessage(
        channel: '#webhooks',
        text: "Hello #{receiver.name} :wave: :speech_balloon:!",
        username: "Yakitty-Yak",
        attachments: [
              {
                  fallback: "XYZ",
                  pretext: "Incoming from _Yakitty-Yak_ ",
                  title: "Chat Request",
                  text: "You have received a new request from #{user.name}. Because '#{skill}' is a skill of yours, they would like to discuss '#{Request.last.topic}' with you.  \nThey have requested to meet at #{start_time.strftime("%a, %d %b")}.",
                  color: "#38B684",
                  actions: [
                  {
                      "name": "accept",
                      "text": "Accept",
                      "style": "primary",
                      "type": "button",
                      "value": "https://www.yakitty-yak.world/requests/#{id}/accept"
                  },
                  {
                      "name": "reject",
                      "text": "Reject",
                      "style": "danger",
                      "type": "button",
                      "value": "https://www.yakitty-yak.world/requests/#{id}/reject"
                  }
              ]

              }
          ].to_json
          )

    else
      client.chat_postMessage(
        channel: '#webhooks',
        text: "Hello #{receiver.name} :wave: :speech_balloon:!",
        username: "Yakitty-Yak",
        attachments: [
              {
                  fallback: "XYZ",
                  # pretext: "Incoming from _Yakitty-Yak_ ",
                  title: "Chat Request",
                  text: "You have received a new request from #{user.name}. Because '#{skill}' is a skill of yours, they would like to discuss '#{Request.last.topic}' with you.  \nThey have requested to meet at #{Request.last.start_time.strftime("%a, %d %b")}.",
                  color: "#38B684",
                  actions: [
                  {
                      "name": "accept",
                      "text": "Accept",
                      "style": "primary",
                      "type": "button",
                      # "value": "http://29e197de.ngrok.io/requests/#{id}/accept"
                      "value": id
                      # "response_url": "http://29e197de.ngrok.io/requests/#{id}/accept"
                  },
                  {
                      "name": "reject",
                      "text": "Reject",
                      "style": "danger",
                      "type": "button",
                      # "value": "http://29e197de.ngrok.io/requests/#{id}/reject"
                      "value": id

                  }
              ]

              }
          ].to_json
          )
    end

  end
end

