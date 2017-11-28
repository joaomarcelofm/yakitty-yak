class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  provider :slack, 'API_KEY', 'API_SECRET', scope: 'identity.basic', name: :sign_in_with_slack
  provider :slack, 'API_KEY', 'API_SECRET', scope: 'team:read,users:read,identify,bot'
end
