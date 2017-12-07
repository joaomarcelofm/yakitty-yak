require "open-uri"

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :omniauth_providers => [:slack, :google_oauth2]

  has_many :requests
  has_many :meetings, through: :requests

  belongs_to :team

  has_many :user_skills
  has_many :skills, through: :user_skills

  has_many :user_interests
  has_many :interests, through: :user_interests
  has_many :events

  def self.from_omniauth(auth)

    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :name, :image)
    team = Team.find_by(team_uid: auth.info.team_id)

    if team
      user_params[:team_id] = team.id
    else
      team = Team.create(team_uid: auth.info.team_id, name: auth.info.team)
      user_params[:team_id] = team.id
    end

    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = auth.credentials.expires
    user_params = user_params.to_h


    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.

    if user
      user.update(user_params)
    else
      user = User.new(user_params)

      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save

    end
    return user
  end

  def self.find_for_google_oauth2(oauth, signed_in_resource=nil)
    credentials = oauth.credentials
    data = oauth.info
    user = User.where(email: data["email"]).first
    user.get_google_calendars  # Wait for next section
    user
  end

  def call_api(url)
    response = open(url)
    JSON.parse(response.read)
  end

  def get_google_calendars
    url = "https://www.googleapis.com/calendar/v3/users/me/calendarList?access_token=#{token}"
    response = open(url)
    json = JSON.parse(response.read)
    calendars = json["items"]
    calendars.each { |cal| get_events_for_calendar(cal) }
  end

  def get_events_for_calendar(cal)

    url = "https://www.googleapis.com/calendar/v3/calendars/#{cal["id"]}/events?access_token=#{token}"
    response = open(url)
    json = JSON.parse(response.read)
    my_events = json["items"]

    my_events.each do |event|
      name = event["summary"] || "no name"
      creator = event["creator"] ? event["creator"]["email"] : nil
      start = event["start"] ? event["start"]["dateTime"] : nil
      status = event["status"] || nil
      link = event["htmlLink"] || nil
      calendar = cal["summary"] || nil

      events.create(name: name,
        creator: creator,
        status: status,
        start: start,
        link: link,
        calendar: calendar
        )
    end
  end

  def first_name
    name_array = name.split
    return name_array[0]
  end

  def last_name
    name_array = name.split
    return name_array[-1]
  end

  def meeting_list
    meetings = Meeting.all
    user_meetings = []
    meetings.each do |meeting|
      user_meetings << meeting if meeting.request.user == self
      user_meetings << meeting if meeting.request.receiver == self
    end
    user_meetings.sort_by!(&:created_at).reverse!
  end


  def team_meetings
    team = self.team
    team.users.each do |user|
      p user.meetings
      raise
    end

  def requests_received
    requests = Request.all
    received = []
    requests.each { |request| received << request.receiver == self }
    received.size

  end
end
