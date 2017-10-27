require "spec_helper"

RSpec.describe StockSummary::Calculator do
  describe '#get_summary' do
    let(:stock_prices) do
      [ 175.2, 172.3, 171.9, 176.7 ]
    end

    let(:correct_summary) do
      {
        stock_return: 1.5,
        maximum_drawdown: 0.02
      }
    end

    subject(:summary) { described_class.new.get_summary(stock_prices) }

    it 'returns correct summary' do
      expect(summary).to eq(correct_summary)
    end
  end
end
