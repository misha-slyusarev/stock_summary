require 'slack-ruby-client'

class StockSummary::Slack
  SLACK_CHANNEL = '#general'
  # TODO: make channel a parameter

  def initialize
    Slack.configure do |config|
      config.token = ENV['SLACK_TOKEN'] or fail 'Missing SLACK_TOKEN env'
    end

    @client = Slack::Web::Client.new
  end

  def push(message)
    @client.chat_postMessage(channel: SLACK_CHANNEL, text: message)
  end
end
