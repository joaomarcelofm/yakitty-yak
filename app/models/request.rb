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
    client.chat_postMessage(channel: receiver.uid, text: 'Hello Sunshine')
  end


end
