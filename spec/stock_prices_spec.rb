require "spec_helper"

RSpec.describe StockSummary::StockPrices do
  describe '#fetch' do
    let(:response) do
      {
        "dataset_data": {
            "limit": nil,
            "transform": nil,
            "column_index": nil,
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
            "collapse": nil,
            "order": nil
          }
        }
    end

    let(:expected_data) do
      {
        '2017-10-25' => { open: 171.9, high: 172.25, low: 168.89 },
        '2017-10-24' => { open: 172.3, high: 173.24, low: 171.5 },
        '2017-10-23' => { open: 175.2, high: 175.34, low: 171.25 }
      }
    end

    let(:api_key) { 'KJBIURKBWBWDBO' }
    let(:ticker) { 'SPY' }
    let(:start_date) { '2017-10-23' }

    subject(:request) { described_class.new(api_key, ticker, start_date).get_data }

    before do
      allow(Net::HTTP).to receive(:get).and_return(response)
    end

    it 'returns requested data' do
      expect(request).to eq(expected_data)
    end
  end
end
