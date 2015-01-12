require_relative '../../spec_helper'

RSpec.describe Tictail::Api, vcr: true do
  let(:api) { Tictail::Api.new }
  let(:email) { ENV['TICTAIL_EMAIL'] }
  let(:password) { ENV['TICTAIL_PASSWORD'] }

  let(:fetcher) { Tictail::Fetcher.new(email, password) }
  let(:page) { fetcher.home_page }
  let(:store) { Tictail::Store.new(page) }
  let(:store_id) { store.store_id }

  before :each do
    api.store_id = store.store_id
  end

  describe "#get" do
    it "calls the method and gets data as a hash" do
      navigation = api.get("store.navigation.get.many")

      keys = ["store_id", "used_by", "label", "parent_id", "position", "id"]

      expect(navigation).to be_an Array
      expect(navigation.first).to be_a Hash
      expect(navigation.first.keys).to match_array(keys)
    end
  end

  describe "#sign_in" do
    it "signs you in the store" do
      home_page = api.sign_in(email, password)
      expect(home_page.title).to eq "Tictail - Dashboard"
    end
  end
end
