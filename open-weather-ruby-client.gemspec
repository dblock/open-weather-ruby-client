# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'open_weather/version'

Gem::Specification.new do |s|
  s.name = 'open-weather-ruby-client'
  s.bindir = 'bin'
  s.version = OpenWeather::VERSION
  s.authors = ['Daniel Doubrovkine']
  s.email = 'dblock@dblock.org'
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 1.3.6'
  s.files = Dir['{bin,lib}/**/*'] + ['README.md', 'LICENSE.md', 'CHANGELOG.md']
  s.require_paths = ['lib']
  s.homepage = 'http://github.com/dblock/open-weather-ruby-client'
  s.licenses = ['MIT']
  s.summary = 'OpenWeather API Ruby client.'
  s.add_dependency 'activesupport'
  s.add_dependency 'faraday', '>= 0.9'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'hashie'
end
