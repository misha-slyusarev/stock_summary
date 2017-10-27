require 'json'
require 'net/http'

class StockSummary::StockPrices
  WIKI_PATH='https://www.quandl.com/api/v3/datasets/WIKI'
  CLOSE_PRICE_ID = 4

  def initialize
    @api_token = ENV['QUANDL_TOKEN'] or fail 'Missing QUANDL_TOKEN env'
  end

  def get_prices(ticker, start_date)
    @ticker = ticker
    @start_date = start_date

    fetch_data
    extract_prices
  end

  private

    def fetch_data
      response = Net::HTTP.get(request_uri)
      @received_data = JSON.parse(response)
    rescue => e
      puts("Couldn't fetch data")
      puts(e)
    end

    def extract_prices
      @received_data['dataset_data']['data'].map { |d| d[CLOSE_PRICE_ID] }.reverse
    end

    def request_uri
      url = "#{WIKI_PATH}/#{@ticker}/data.json?api_key=#{@api_key}&start_date=#{@start_date}"
      URI(url)
    rescue URI::Error => e
      puts("Couldn't parse URL: #{url}")
      puts(e)
    end
end
