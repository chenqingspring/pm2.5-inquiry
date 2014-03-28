require 'rack/test'
require 'rack'

include Rack::Test::Methods

def app
  Sinatra::Application
end
