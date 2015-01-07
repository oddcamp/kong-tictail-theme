module Tictail
  class Store
    def initialize(page)
      @page = page
    end

    def store_id
      store_data["id"]
    end

    private

    def store_data
      store = @page.body.scan(/var ClientSession = (.*);\n/)[0][0]
      store = JSON.parse(store)
      store = store["storekeeper"]["stores"].first[1]
      store["url"] = "/"
      store
    end
  end
end
