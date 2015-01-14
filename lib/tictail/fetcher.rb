# BANANABAD CODE.
# You have been warned.

require 'rubygems'
require 'mechanize'
require 'json'
require 'stringex'

module Tictail
  class Fetcher
    attr_reader :store_id, :agent, :api, :store_data, :home_page

    # @param [String] email
    # @param [String] password
    def initialize(email, password)
      @api = Tictail::Api.new
      @home_page = @api.sign_in(email, password)

      if @home_page.title == "Tictail - Log in"
        puts "Error. Could not log in. Wrong email or password? <3"
        exit
      end

      store = Tictail::Store.new(@home_page)
      @store_data = store.store_data

      @api.store_id = store.store_id

      @store_data["logotype"] = store.logo
      @store_data["description"] = store.description
      @store_data["products"] = store.products

      navigation = Tictail::Navigation.new(self)
      @store_data["navigation"] = navigation.navigation
      @store_data["original_navigation"] = navigation.original_navigation
    end

    # @param [String] file
    def save(file = "store.json")
      File.open(file, "w") do |f|
        f.write(JSON.pretty_generate(@store_data))
      end
      puts "Fetch successful! View your data in #{file}"
    end
  end
end
