class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:slack]


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

  has_many :user_meetings
  has_many :meetings, through: :user_meetings
  belongs_to :team

  has_many :user_meetings
  has_many :meetings, through: :user_meetings
end
