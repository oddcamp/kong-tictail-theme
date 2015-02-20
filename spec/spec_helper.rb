ENV['RACK_ENV'] = 'test'

require 'pry'
require 'rack/test/methods'
require 'vcr'

require_relative File.join('..', 'app')
require_relative File.join('..', 'lib/tictail')

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
  config.configure_rspec_metadata!
end

RSpec.configure do |config|
  include Rack::Test::Methods

  def app
    App
  end
end
