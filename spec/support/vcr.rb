# frozen_string_literal: true

require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/open_weather'
  config.hook_into :webmock
  config.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [
      :method,
      VCR.request_matchers.uri_without_param(:appid)
    ]
  }
  config.configure_rspec_metadata!
  config.before_record do |i|
    i.request.uri.gsub!(ENV['OPEN_WEATHER_API_KEY'], 'api-key') if ENV.key?('OPEN_WEATHER_API_KEY')
    i.response.body.force_encoding('UTF-8')
  end
end
