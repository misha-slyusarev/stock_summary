require 'stock_summary/version'
require 'stock_summary/calculator'
require 'stock_summary/slack'
require 'stock_summary/stock_prices'
require 'stock_summary/aggregator'

module StockSummary
  class << self
    def get_stock_summary(ticker, start_date)
      Aggregator.new(ticker, start_date).get_stock_summary
    end
  end
end
