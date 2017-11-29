# require 'twilio-ruby'

# #twilio requires us to 1) get tokens and create

# # put your own credentials here
# account_sid = 'ACa9081cc002ee2a814cc7fdbb745a0abf'
# auth_token = '87ad1cfb53346fcac1938013e4fe46a4'

# # set up a client to talk to the Twilio REST API
# client = Twilio::REST::Client.new account_sid, auth_token

# puts client.inspect

# room = client.video.rooms('DailyStandup').fetch()

# puts room

# # Create an Access Token
# token = Twilio::JWT::AccessToken.new ACCOUNT_SID, API_KEY_SID, API_KEY_SECRET,
#     ttl=3600,
#     identity='example-user'

# # Grant access to Video
# grant = Twilio::JWT::AccessToken::VideoGrant.new
# grant.room = 'cool room'
# token.add_grant grant

# def create_grant
#     grant = Twilio::JWT::AccessToken::VideoGrant.new
#     grant.room = @meeting.room_name
#     grant
# end


