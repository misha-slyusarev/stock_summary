require "spec_helper"

RSpec.describe StockSummary::StockPrices do
  describe '#get_prices' do
    let(:response) do
      '{
        "dataset_data": {
            "limit": null,
            "transform": null,
            "column_index": null,
            "column_names": [
                "Date",
                "Open",
                "High",
                "Low",
                "Close",
                "Volume",
                "Ex-Dividend",
                "Split Ratio",
                "Adj. Open",
                "Adj. High",
                "Adj. Low",
                "Adj. Close",
                "Adj. Volume"
            ],
            "start_date": "2017-10-01",
            "end_date": "2017-10-25",
            "frequency": "daily",
            "data": [
                [
                    "2017-10-26",
                    176.7,
                    172.25,
                    168.89,
                    170.6,
                    15095603,
                    0,
                    1,
                    171.9,
                    172.25,
                    168.89,
                    170.6,
                    15095603
                ],
                [
                    "2017-10-25",
                    171.9,
                    172.25,
                    168.89,
                    170.6,
                    15095603,
                    0,
                    1,
                    171.9,
                    172.25,
                    168.89,
                    170.6,
                    15095603
                ],
                [
                    "2017-10-24",
                    172.3,
                    173.24,
                    171.5,
                    171.8,
                    11629341,
                    0,
                    1,
                    172.3,
                    173.24,
                    171.5,
                    171.8,
                    11629341
                ],
                [
                    "2017-10-23",
                    175.2,
                    175.34,
                    171.25,
                    171.27,
                    13622072,
                    0,
                    1,
                    175.2,
                    175.34,
                    171.25,
                    171.27,
                    13622072
                ]
            ],
            "collapse": null,
            "order": null
          }
        }'
    end

    let(:stock_prices) do
      [ 175.2, 172.3, 171.9, 176.7 ]
    end

    let(:ticker) { 'FB' }
    let(:start_date) { '2017-10-23' }

    subject(:request) { described_class.new.get_prices(ticker, start_date) }

    before do
      allow(Net::HTTP).to receive(:get).and_return(response)
      allow(ENV).to receive(:[]).with('STOCK_PRICES_TOKEN').and_return('Xls7e')
    end

    it 'returns list of stock prices' do
      expect(request).to eq(stock_prices)
    end
  end
end
