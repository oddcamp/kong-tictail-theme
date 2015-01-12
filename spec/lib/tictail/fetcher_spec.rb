require_relative '../../spec_helper'

RSpec.describe Tictail::Fetcher, vcr: true do
  let(:email) { ENV['TICTAIL_EMAIL'] }
  let(:password) { ENV['TICTAIL_PASSWORD'] }

  let(:fetcher) { Tictail::Fetcher.new(email, password) }

  describe "#save" do
    it "outputs a message after save" do
      expected_message = "Fetch successful! View your data in store.json\n"

      expect do
        fetcher.save
      end.to output(expected_message).to_stdout
    end

    it "saves contents into store.json file" do
      file = File.new File.expand_path("./store.json")

      file_modified_seconds_ago = Time.now.to_i - file.mtime.to_i
      expect(file_modified_seconds_ago).to satisfy { |seconds| seconds < 2 }
    end
  end
end
