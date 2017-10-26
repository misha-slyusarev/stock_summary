class StockSummary::StockPrices
  WIKI_PATH='https://www.quandl.com/api/v3/datasets/WIKI'

  def initialize(api_key, ticker, start_date)
    @api_key = api_key
    @ticker = ticker
    @start_date = start_date
  end

  def get_data
    fetch
    extract
  end

  private

    def fetch
      @received_data = Net::HTTP.get(request_uri)
    rescue => e
      # TODO: figure out logging
      puts("Couldn't fetch data")
      puts(e)
    end

    def extract
      @received_data[:dataset_data][:data].each_with_object({}) do |point, res|
        date, open_price, high_price, low_price = point[0..3]
        res[date] = { open: open_price, high: high_price, low: low_price }
      end
    end

    def request_uri
      url = "#{WIKI_PATH}/#{@ticker}/data.json?api_key=#{@api_key}&start_date=#{@start_date}"
      @uri ||= URI(url)
    rescue URI::Error => e
      # TODO: figure out logging
      puts("Couldn't parse URL: #{url}")
      puts(e)
    end
end
