require_relative '../../spec_helper'

RSpec.describe Tictail::Store do
  let(:fetcher) { Tictail::Fetcher.new(ENV['TICTAIL_EMAIL'], ENV['TICTAIL_PASSWORD']) }
  let(:page) { fetcher.home_page }
  let(:store) { Tictail::Store.new(page) }

  describe "#store_id" do
    it "returns store id" do
      expect(store.store_id).to be_a Fixnum
    end
  end

  describe "#store_data" do
    it "returns store data as a hash" do
      expect(store.store_data).to be_a Hash
    end
  end

  describe "#logo" do
    it "returns logo" do
      expect(store.logo).to be_a Hash
    end
  end

  describe "#description" do
    it "returns description" do
      expect(store.description).to be_a String
    end
  end

  describe "#products" do
    it "returns products array" do
      expect(store.products).to be_an Array
    end
  end
end
