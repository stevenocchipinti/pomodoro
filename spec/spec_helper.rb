require "rspec"
require "capybara"
require "capybara/dsl"
require "capybara/rspec"

require_relative "./../application.rb"

Capybara.app = Sinatra::Application
Capybara.default_wait_time = 10

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Capybara::DSL
end
