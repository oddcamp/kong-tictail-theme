require_relative '../../spec_helper'

RSpec.describe Tictail::Layout do
  let(:layout) { Tictail::Layout.new }

  describe "#product_page" do
    it "prints out the contents of product page" do
      expect(layout.product_page).to match("{{#product_page}}")
    end
  end

  describe "#list_page" do
    it "prints out the contents of list page" do
      expect(layout.list_page).to match("{{#list_page}}")
    end
  end

  describe "#about_page" do
    it "prints out the contents of about page" do
      expect(layout.about_page).to match("{{#about_page}}")
    end
  end
end
