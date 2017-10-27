require "spec_helper"

RSpec.describe StockSummary::Aggregator do

  describe '#get_stock_summary' do
    let(:ticker) { 'FB' }
    let(:start_date) { '2017-10-23' }
    let(:message) { "Stock ticker FB has 1.5$ return and 2.0% maximum drawdown from 2017-10-23 up to now" }
    let(:stock_prices) { [ 175.2, 172.3, 171.9, 176.7 ] }

    subject(:get_stock_summary) { described_class.new(ticker, start_date).get_stock_summary }

    before do
      allow_any_instance_of(Slack::Web::Client).to receive(:chat_postMessage)
      allow_any_instance_of(StockSummary::StockPrices).to receive(:get_prices).and_return(stock_prices)
      allow(ENV).to receive(:[]).with('SLACK_TOKEN').and_return('Xls7e')
      allow(ENV).to receive(:[]).with('STOCK_PRICES_TOKEN').and_return('Xls7e')
      expect_any_instance_of(StockSummary::Slack).to receive(:push).with(message)
    end

    it 'pushes summary to slack' do
      get_stock_summary
    end

    it 'outputs summary to CLI' do
      expect { get_stock_summary }.to output(message + "\n").to_stdout
    end
  end
end
