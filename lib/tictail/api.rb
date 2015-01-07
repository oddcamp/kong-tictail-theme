module Tictail
  class Api
    attr_accessor :agent, :store_id

    def initialize
      @agent = Mechanize.new
    end

    def get(method)
      url = 'https://tictail.com/apiv2/rpc/v1/?jsonrpc={"jsonrpc":"2.0","method":"' + method + '","params":{"store_id":' + @store_id.to_s + '},"id":null}'
      data = @agent.get(url).body
      data = JSON.parse(data)
      data["result"]
    end

    def get_full(method)
      url = 'https://tictail.com/apiv2/rpc/v1/?jsonrpc=' + method
      data = @agent.get(url).body
      data = JSON.parse(data)
      data["result"]
    end

    def sign_in(email, password)
      page = @agent.get('https://tictail.com/user/signin')

      sign_in_form = page.form()
      sign_in_form.email = email
      sign_in_form.passwd = password

      @agent.submit(sign_in_form, sign_in_form.buttons.first)
    end
  end
end
