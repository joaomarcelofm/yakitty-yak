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
    client.chat_postMessage(channel: receiver.uid, text: "Hello #{receiver.name}! You have recieved a new request from #{user.name}.  Because '#{Request.last.skill}' is a skill of yours, they would like to discuss '#{Request.last.topic}' with you.  They have requested to meet at #{Request.last.start_time.strftime("%a, %d %b")}")
  end


end
