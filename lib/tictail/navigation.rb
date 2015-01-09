module Tictail
  class Navigation
    attr_reader :navigation, :original_navigation

    # @param [Tictail::Fetcher] fetcher
    def initialize(fetcher)
      @navigation = fetcher.api.get("store.navigation.get.many")
      @original_navigation = @navigation.clone

      remove_subnavigation_from_main
      fix_navigation_attributes
      fix_subnav_and_nav_structure(subnav)
    end

    private

    # @return [Array]
    def subnav
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
  end
end
