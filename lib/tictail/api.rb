module Tictail
  class Api
    attr_accessor :agent, :store_id

    # @param [Fixnum] store_id
    def initialize(store_id = nil)
      @agent = Mechanize.new
      @store_id = store_id
    end

    # @param [String] method
    # @return [Hash]
    def get(method)
      url = 'https://tictail.com/apiv2/rpc/v1/?jsonrpc={"jsonrpc":"2.0","method":"' + method + '","params":{"store_id":' + @store_id.to_s + '},"id":null}'
      data = @agent.get(url).body
      data = JSON.parse(data)
      data["result"]
    end

    # @param [String] method
    # @return [Hash]
    def get_full(method)
      url = 'https://tictail.com/apiv2/rpc/v1/?jsonrpc=' + method
      data = @agent.get(url).body
      data = JSON.parse(data)
      data["result"]
    end

    # @param [String] email
    # @param [String] password
    # @return [Mechanize::Page]
    def sign_in(email, password)
      page = @agent.get('https://tictail.com/user/signin')

      sign_in_form = page.form()
      sign_in_form.email = email
      sign_in_form.passwd = password

      @agent.submit(sign_in_form, sign_in_form.buttons.first)
    end
  end
end
