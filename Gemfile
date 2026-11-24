# frozen_string_literal: true

source 'http://rubygems.org'

gemspec

group :development do
  gem 'appraisal'
  gem 'benchmark-ips'
  if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3')
    gem 'commonmarker', '~> 2.10', require: false
    gem 'ruby-gem-release', '0.9.0', require: false
  end
end

group :test do
  gem 'simplecov'
  gem 'simplecov-lcov', require: false
end
