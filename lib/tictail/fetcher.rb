# BANANABAD CODE.
# You have been warned.

require 'rubygems'
require 'mechanize'
require 'json'
require 'stringex'

module Tictail
  class Fetcher
    attr_accessor :store_id, :agent, :api, :store, :store_data, :logo, :description, :navigation, :original_navigation
    attr_reader :home_page

    def initialize(email, password)
      @agent = Mechanize.new

      @home_page = sign_in(email, password)
      if @home_page.title == "Tictail - Log in"
        puts "Error. Could not log in. Wrong email or password? <3"
        exit
      end

      @store = Tictail::Store.new(@home_page)
      @store_id = @store.store_id
      @store_data = @store.store_data

      @api = Tictail::Api.new(@agent, @store_id)

      @logo = @store.logo
      @products = @store.products
      @description = @store.description

      navigation()

      @store_data["logotype"] = @logo
      @store_data["description"] = @description
      @store_data["navigation"] = @navigation
      @store_data["original_navigation"] = @original_navigation
      @store_data["products"] = @products
    end

    def sign_in(email, password)
      page = @agent.get('https://tictail.com/user/signin')

      sign_in_form = page.form()
      sign_in_form.email = email
      sign_in_form.passwd = password

      @agent.submit(sign_in_form, sign_in_form.buttons.first)
    end

    def navigation
      @navigation = @api.get("store.navigation.get.many")
      @original_navigation = @navigation.clone

      subnav = get_subnav()
      remove_subnavigation_from_main()
      fix_navigation_attributes()
      fix_subnav_and_nav_structure(subnav)
    end

    def get_subnav
      @navigation.select { |item| item["parent_id"] != 0 }
    end

    def remove_subnavigation_from_main
      @navigation.select! { |item| item["parent_id"] == 0 }
    end

    def fix_navigation_attributes
      @navigation.each do |item|
        item["children"] = []
        item["url"] = "/products/" << item["label"].to_url
        item["is_current"] = false
      end
    end

    def fix_subnav_and_nav_structure(subnav)
      subnav.each do |subitem|
        parent = @navigation.select { |item| item["id"] == subitem["parent_id"] }[0]
        parent["children"] << subitem
        parent["has_children"] = true
        subitem["url"] = parent["url"] + "/" + subitem["label"].to_url
        subitem["is_current"] = false
      end
    end

    def save
      File.open("store.json","w") do |f|
        f.write(JSON.pretty_generate(@store_data))
      end
      puts "Fetch successful! View your data in store.json"
    end
  end
end
