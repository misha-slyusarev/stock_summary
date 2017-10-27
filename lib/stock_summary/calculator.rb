class StockSummary::Calculator
  ROUND_PRECISION = 2
  #TODO: make it a parameter

  def get_summary(stock_prices)
    @stock_prices = stock_prices

    {
      stock_return: stock_return,
      maximum_drawdown: maximum_drawdown
    }
  end

  private

    def stock_return
      (@stock_prices.last - @stock_prices.first).round(ROUND_PRECISION)
    end

    def maximum_drawdown
      max = prev_max = min = @stock_prices.first

      @stock_prices.reduce(0) do |drawdown, price|
        if price > max
          prev_max = max
          max = price
        elsif price < min
          min = price
        end

        drawdown = ((prev_max - min) / prev_max).round(ROUND_PRECISION)
      end
    end
end
