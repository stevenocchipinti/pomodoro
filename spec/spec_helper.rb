require "rspec"
require "capybara"
require "capybara/dsl"
require "capybara/rspec"
require "capybara-webkit"

require_relative "./../application.rb"

Capybara.app = Sinatra::Application
Capybara.default_wait_time = 10
Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Capybara::DSL
end
