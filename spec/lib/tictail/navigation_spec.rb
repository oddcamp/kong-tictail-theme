require_relative '../../spec_helper'

RSpec.describe Tictail::Navigation do
  let(:email) { ENV['TICTAIL_EMAIL'] }
  let(:password) { ENV['TICTAIL_PASSWORD'] }
  let(:fetcher) { Tictail::Fetcher.new(email, password) }

  let(:navigation) { Tictail::Navigation.new(fetcher) }

  describe "#navigation" do
    it "returns navigation hash" do
      keys = ["store_id", "used_by", "label", "parent_id", "position", "id", "children", "url", "is_current"]

      expect(navigation.navigation).to be_an Array
      expect(navigation.navigation.first).to be_a Hash
      expect(navigation.navigation.first.keys).to match_array(keys)
    end
  end

  describe "#original_navigation" do
    it "returns original navigation hash" do
      keys = ["id", "label", "parent_id", "position", "store_id", "used_by"]

      expect(navigation.original_navigation).to be_an Array
      expect(navigation.original_navigation.first).to be_a Hash
      expect(navigation.original_navigation.first.keys).to match_array(keys)
    end
  end
end
