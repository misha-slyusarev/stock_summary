require 'json'
require 'net/http'

class StockSummary::StockPrices
  WIKI_PATH='https://www.quandl.com/api/v3/datasets/WIKI'

  def initialize
    @api_token = ENV['STOCK_PRICES_TOKEN'] or fail 'Missing STOCK_PRICES_TOKEN env'
  end

  def get_prices(ticker, start_date)
    @ticker = ticker
    @start_date = start_date

    fetch
    extract
  end

  private

    def fetch
      response = Net::HTTP.get(request_uri)
      @received_data = JSON.parse(response)
    rescue => e
      # TODO: figure out logging
      puts("Couldn't fetch data")
      puts(e)
    end

    def extract
      @received_data['dataset_data']['data'].map { |point| point[1] }.reverse
    end

    def request_uri
      url = "#{WIKI_PATH}/#{@ticker}/data.json?api_key=#{@api_key}&start_date=#{@start_date}"
      URI(url)
    rescue URI::Error => e
      # TODO: figure out logging
      puts("Couldn't parse URL: #{url}")
      puts(e)
    end
end
