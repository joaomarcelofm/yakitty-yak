class MeetingsController < ApplicationController

  def new
  @meeting = Meeting.new(meeting_params)
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.user = current_user
    if @meeting.save
      redirect_to @meeting
    else
      render 'new'
    end
  end


  def show
    @meeting = Meeting.find(params[:id])
    @token = generate_token(current_user.email)
  end

  private

  def item_params
    params.require(:meeting).permit(:room_name, :date, :time)
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
