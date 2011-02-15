# -*- encoding: utf-8 -*-
require 'lib/mediaburst/version'
 
Gem::Specification.new do |s|
  s.name        = "mediaburst"
  s.version     = Mediaburst::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Hall"]
  s.email       = ["matt@codebeef.com"]
  s.homepage    = "http://www.mediaburst.co.uk/api"
  s.summary     = "Ruby wrapper for the Mediaburst SMS API"
  s.license     = 'ISC'
  s.description = 'Wrapper for the Mediaburst SMS sending API'
  
  s.files       = Dir.glob("lib/**/*") + %w(ISC-LICENSE README.md)
  
  s.add_runtime_dependency('nokogiri')
  
  s.add_development_dependency('webmock')
end