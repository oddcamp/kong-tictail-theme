require_relative '../../spec_helper'

RSpec.describe Tictail::Store do
  let(:fetcher) { Tictail::Fetcher.new(ENV['TICTAIL_EMAIL'], ENV['TICTAIL_PASSWORD']) }
  let(:page) { fetcher.home_page }

  describe "#store_id" do
    it "returns store id" do
      store = Tictail::Store.new(page)
      expect(store.store_id).to be_a Fixnum
    end
  end

  describe "#store_data" do
    it "returns store data as a hash" do
      store = Tictail::Store.new(page)
      expect(store.store_data).to be_a Hash
    end
  end

  describe "#products" do
    it "returns products array" do
      store = Tictail::Store.new(page)
      expect(store.products).to be_an Array
    end
  end
end
