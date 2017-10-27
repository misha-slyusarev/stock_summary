class StockSummary::Aggregator
  def initialize(ticker, start_date)
    @ticker = ticker
    @start_date = start_date
    @prices_api = StockSummary::StockPrices.new
    @calculator = StockSummary::Calculator.new
    @slack = StockSummary::Slack.new
  end

  def get_stock_summary
    get_stock_prices
    calculate_summary
    show_results
  rescue StockSummary::GeneralError
    exit
  end

  private

    def get_stock_prices
      @prices = @prices_api.get_prices(@ticker, @start_date)
    end

    def calculate_summary
      @summary = @calculator.get_summary(@prices)
    end

    def show_results
      @slack.push(result_message)
      puts(result_message)
    end

    def result_message
      "Stock ticker #{@ticker} has #{@summary[:stock_return] * 100}% return "\
      "and #{@summary[:maximum_drawdown] * 100}% maximum drawdown "\
      "from #{@start_date} up until now"
    end
end
