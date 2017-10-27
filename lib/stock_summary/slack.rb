require 'slack-ruby-client'

class StockSummary::Slack
  SLACK_CHANNEL = '#general'

  def initialize
    Slack.configure do |config|
      config.token = ENV['SLACK_TOKEN']
      fail 'Missing SLACK_TOKEN environemnt variable' unless config.token
    end

    @client = Slack::Web::Client.new
  end

  def push(message)
    @client.chat_postMessage(channel: SLACK_CHANNEL, text: message)
  end
end
