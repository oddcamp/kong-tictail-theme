require_relative '../../spec_helper'

RSpec.describe Tictail::Printer do
  let(:layout) { Tictail::Layout.new }
  let(:printer) { Tictail::Printer.new(layout) }

  describe "#print" do
    it "prints out data to theme.moustache file" do
      expected_message = "Build successful! View your theme in theme.mustache (and it's added to your clipboard for convinient CMD+v into Tictail.com\n"

      expect do
        printer.print
      end.to output(expected_message).to_stdout

      file = File.new File.expand_path("./theme.mustache")

      file_modified_seconds_ago = Time.now.to_i - file.mtime.to_i
      expect(file_modified_seconds_ago).to satisfy { |seconds| seconds < 2 }
    end
  end
end
