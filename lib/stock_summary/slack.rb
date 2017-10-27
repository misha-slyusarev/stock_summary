require 'slack-ruby-client'

class StockSummary::Slack
  DEFAULT_SLACK_CHANNEL = '#general'

  def initialize
    Slack.configure do |config|
      config.token = ENV['SLACK_TOKEN'] or fail 'Missing SLACK_TOKEN env'
    end

    @client = Slack::Web::Client.new
    @channel = StockSummary::Config.slack_channel || DEFAULT_SLACK_CHANNEL
  end

  def push(message)
    @client.chat_postMessage(channel: @channel, text: message)
  end
end
