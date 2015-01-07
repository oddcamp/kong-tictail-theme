require_relative '../../spec_helper'

RSpec.describe Tictail::Store do
  let(:fetcher) { Tictail::Fetcher.new(ENV['TICTAIL_EMAIL'], ENV['TICTAIL_PASSWORD']) }
  let(:store_id) { 103026 }

  describe "#store_id" do
    it "returns store id" do
      store = Tictail::Store.new(fetcher.home_page)
      expect(store.store_id).to eq store_id
    end
  end
end
