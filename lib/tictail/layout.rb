module Tictail
  class Layout
    attr_reader :content

    def initialize
      pages = about_page + list_page + product_page
      @content = layout.sub(/\{\{\{yield\}\}\}/, pages)
    end

    # @return [String]
    def about_page
      page = File.read("./templates/about_page.mustache")

      page.sub(/\<img src=\"\/assets/, '<img src="//cdn.konginitiative.com/assets')
    end

    # @return [String]
    def list_page
      page = File.read("./templates/list_page.mustache")

      page.sub(/\{\{\{price_with_currency\}\}\}/, '{{price_with_currency}}').
            sub(/\<img src=\"\/assets/, '<img src="//cdn.konginitiative.com/assets')
    end

    # @return [String]
    def product_page
      page = File.read("./templates/product_page.mustache")

      page.sub(/\{\{\{social_buttons\}\}\}/, '{{social_buttons}}').
           sub(/\{\{\{price_with_currency\}\}\}/, '{{price_with_currency}}').
           sub(/\<img src=\"\/assets/, '<img src="//cdn.konginitiative.com/assets').
           sub(/\{\{\{description\}\}\}/, '{{description}}')
    end

    # @return [String]
    def layout
      layout_string = File.read("./templates/layout.mustache")

      layout_string.sub(/\{\{\{search\}\}\}/, '{{search}}').
                    sub(/\<script id=\"theme-builder\" src=\"\/theme-builder.js\"\>\<\/script\>/, '').
                    sub(/\<script src=\"\/assets\/dist\/application.min.js\"\>\<\/script\>/, '<script src="//cdn.konginitiative.com/assets/dist/application.min.js"></script>').
                    sub(/\<link href=\"\/assets\/dist\/application\.css\" rel=\"stylesheet\" type=\"text\/css\"\>/, '<link rel="stylesheet" type="text/css" href="//cdn.konginitiative.com/assets/dist/application.css">').
                    sub(/\<link href=\"\/assets\/images/, '<link href="//cdn.konginitiative.com/assets/images').
                    sub(/\<img src=\"\/assets/, '<img src="//cdn.konginitiative.com/assets').
                    sub(/\{\{\> tictail\/misc\}\}/, '').
                    gsub(/\{\{#has_children\}\}/, '{{#children?}}').
                    gsub(/\{\{\/has_children\}\}/, '{{/children?}}')
    end
  end
end
