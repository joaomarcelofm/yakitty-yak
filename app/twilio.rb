require 'twilio-ruby'

# Required for any Twilio Access Token
account_sid = 'ACa9081cc002ee2a814cc7fdbb745a0abf'
auth_token = '87ad1cfb53346fcac1938013e4fe46a4'
api_key = 'SK209a70a50bfc599be14bbf464e3e80a9'
api_secret = 'UnT4Vfrt7JhEyk6LbDnw1aU4lHew2fW3'

identity = 'jared'

# Create an Access Token
token = Twilio::JWT::AccessToken.new(account_sid, api_key, api_secret, identity);

# Create Video grant for our token
grant = Twilio::JWT::AccessToken::VideoGrant.new
grant.room = 'yak'
token.add_grant(grant)

# Generate the token
puts token.to_jwt
