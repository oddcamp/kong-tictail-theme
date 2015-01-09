module Tictail
  class Store

    # @param [Mechanize::Page] page
    def initialize(page)
      @page = page

      @api = Tictail::Api.new
      @api.store_id = store_id
      @api.sign_in(ENV['TICTAIL_EMAIL'], ENV['TICTAIL_PASSWORD'])
    end

    # @return [Fixnum]
    def store_id
      store_data["id"]
    end

    def store_data
      store = @page.body.scan(/var ClientSession = (.*);\n/)[0][0]
      store = JSON.parse(store)
      store = store["storekeeper"]["stores"].first[1]
      store["url"] = "/"
      store
    end

    def logo
      logo = @api.get("store.media.logotype.get")["logotype"]
      logo["sizes"].each do |key, value|
        name = "url-" << key
        logo[name] = value
      end
      logo.delete("sizes")
      logo
    end

    def description
      @api.get("store.description.get")["description"]
    end

    def products
      products = @api.get_full('{"jsonrpc":"2.0","method":"store.product.search","params":{"store_id":' + store_id.to_s + ',"published":false,"limit":17,"offset":0,"order_by":"position","descending":false},"id":null}')

      products.each do |product|
        product_extra = @api.get_full('{"jsonrpc":"2.0","method":"store.product.get","params":{"store_id":' + store_id.to_s + ',"slug":"'+ product["url"][9,1000] +'","published":false},"id":null}')
        product["all_images"] = product_extra["images"]

        product = fix_stock(product)
        product["price_with_currency"] = product["price"].split(".")[0] + " <span class='currency currency_sek'>"+ store_data["currency"] + "</span>"

        if product.has_key?("primary_image")
          product["primary_image"]["sizes"].each do |key, value|
            name = "url-" << key
            product["primary_image"][name] = value
          end
          product["primary_image"].delete("sizes")
        end

        unless product["all_images"].nil?
          product["all_images"].each do |image|
            image["sizes"].each do |key, value|
              name = "url-" << key
              image[name] = value
            end
            image.delete("sizes")
          end
        end
      end
      products
    end

    private

    def fix_stock(product)
      if product["out_of_stock"] == 1
        product["out_of_stock"] = true
        product["in_stock"] = false
      else
        product["out_of_stock"] = false
        product["in_stock"] = true
      end
      product
    end
  end
end
