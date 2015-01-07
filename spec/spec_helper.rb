ENV['RACK_ENV'] = 'test'

require 'rack/test/methods'

require_relative File.join('..', 'app')

require_relative File.join('..', 'lib/tictail')
require_relative File.join('..', 'lib/printer')

RSpec.configure do |config|
  include Rack::Test::Methods

  def app
    App
  end
end
