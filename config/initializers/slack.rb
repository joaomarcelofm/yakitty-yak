Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

Slack.configure do |config|
  config.token = ENV['SLACKCOCO_API_TOKEN']
end
