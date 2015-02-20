require_relative '../../spec_helper'

RSpec.describe Tictail::Printer do
  let(:layout) { Tictail::Layout.new }
  let(:printer) { Tictail::Printer.new(layout) }
  let(:file) { File.new File.expand_path("./theme.mustache") }

  describe "#print" do
    it "prints out a message to stdout" do
      expected_message = "Build successful! View your theme in theme.mustache (and it's added to your clipboard for convinient CMD+v into Tictail.com\n"

      expect do
        printer.print
      end.to output(expected_message).to_stdout
    end

    it "modifies theme.moustache file" do
      file_modified_seconds_ago = Time.now.to_i - file.mtime.to_i
      expect(file_modified_seconds_ago).to satisfy { |seconds| seconds < 2 }
    end

    it "prints out data to theme.moustache file" do
      file_content = file.read

      expect(file_content).to match("{{#product_page}}")
      expect(file_content).to match("{{#list_page}}")
      expect(file_content).to match("{{#about_page}}")
    end
  end
end
