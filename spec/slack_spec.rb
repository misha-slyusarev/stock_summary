require "spec_helper"

RSpec.describe StockSummary::Slack do
  describe '#push' do
    let(:stock_summary) do
      {
        stock_return: 1.5,
        maximum_drawdown: 0.02
      }
    end
    let(:message) { 'slack message' }
    let(:slack_rseponse) { { ok: true } }

    subject(:push) { described_class.new.push(message) }

    before do
      allow_any_instance_of(Slack::Web::Client).to receive(:chat_postMessage).and_return(slack_response)
      allow(ENV).to receive(:[]).with('SLACK_TOKEN').and_return('Xls7e')
    end

    # it 'succesfuly pushes stock summary to the channel' do
    # #  expect(push).to
    # end
  end
end
