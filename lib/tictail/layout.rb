module Tictail
  class Layout
    attr_reader :content

    def initialize
      pages = about_page + list_page + product_page
      @content = layout.gsub(/\{\{\{yield\}\}\}/, pages)
    end

    # @return [String]
    def about_page
      page = File.read("./templates/about_page.mustache")

      page.gsub(/\<img src="\/assets/, '<img src="https://kong-cdn.kollegorna.se/assets')
    end

    # @return [String]
    def list_page
      page = File.read("./templates/list_page.mustache")

      page.gsub(/\{\{\{price_with_currency\}\}\}/, '{{price_with_currency}}').
           gsub(/\<img src="\/assets/, '<img src="https://kong-cdn.kollegorna.se/assets')
    end

    # @return [String]
    def product_page
      page = File.read("./templates/product_page.mustache")

      page.gsub(/\{\{\{social_buttons\}\}\}/, '{{social_buttons}}').
           gsub(/\{\{\{price_with_currency\}\}\}/, '{{price_with_currency}}').
           gsub(/\<img src="\/assets/, '<img src="https://kong-cdn.kollegorna.se/assets').
           gsub(/\{\{\{description\}\}\}/, '{{description}}')
    end

    # @return [String]
    def layout
      layout_string = File.read("./templates/layout.mustache")

      layout_string.gsub(/\{\{\{search\}\}\}/, '{{search}}').
                    gsub(/\<script id="theme-builder" src="\/theme-builder.js">\<\/script>/, '').
                    gsub(/\<script src="\/assets\/dist\/application.min.js">\<\/script>/, '<script src="https://kong-cdn.kollegorna.se/assets/dist/application.min.js"></script>').
                    gsub(/\<link href="\/assets\/dist\/application\.css" rel="stylesheet" type="text\/css">/, '<link rel="stylesheet" type="text/css" href="https://kong-cdn.kollegorna.se/assets/dist/application.css">').
                    gsub(/\<link href="\/assets\/images/, '<link href="https://kong-cdn.kollegorna.se/assets/images').
                    gsub(/kongmixpanel/, '9d0ac2764fd18a0b68a892557923c0ab').
                    gsub(/\<img src="\/assets/, '<img src="https://kong-cdn.kollegorna.se/assets').
                    gsub(/\{\{\> tictail\/misc\}\}/, '').
                    gsub(/\{\{#has_children\}\}/, '{{#children?}}').
                    gsub(/\{\{\/has_children\}\}/, '{{/children?}}')

    end
  end
end
