require 'rubygems'
require 'rspec'
require 'mocha'
require 'test/unit'
require 'webmock/rspec'

RSpec.configure do |config|
  config.mock_with :mocha
end