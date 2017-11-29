class MeetingsController < ApplicationController
  def new
  end

  def show
    @meeting = Meeting.find(params[:id])
    @token = generate_token(current_user.email)
  end

  private

  def connect(token, room)
    puts "you have joined the room"
  end

  def generate_token(identity)
    grant = create_grant
    token = Twilio::JWT::AccessToken.new(
      ENV['ACCOUNT_SID'],
      ENV['API_KEY_SID'],
      ENV['API_KEY_SECRET'],
      [grant],
      identity: identity
    );
  end

  def create_grant
    grant = Twilio::JWT::AccessToken::VideoGrant.new
    grant.room = @meeting.room_name
    grant
  end
end
