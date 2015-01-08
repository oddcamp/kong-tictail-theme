ENV['RACK_ENV'] = 'test'

require 'pry'
require 'rack/test/methods'

require_relative File.join('..', 'app')
require_relative File.join('..', 'lib/tictail')

RSpec.configure do |config|
  include Rack::Test::Methods

  def app
    App
  end
end
