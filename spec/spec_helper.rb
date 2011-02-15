require 'rubygems'
require 'spec'
require 'mocha'
require 'test/unit'
require 'webmock/rspec'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end