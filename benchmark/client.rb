# frozen_string_literal: true

# Benchmarks OpenWeather::Client end to end, from the HTTP response through
# Faraday, JSON parsing and model construction. Responses are replayed with
# WebMock from the VCR cassettes in spec/fixtures, so no network access or
# API key is needed.
#
#   bundle exec rake benchmark
#   bundle exec ruby benchmark/client.rb [scenario ...]

require 'bundler/setup'
require 'benchmark/ips'
require 'webmock'
require 'yaml'
require 'open-weather-ruby-client'

include WebMock::API # rubocop:disable Style/MixinUsage

WebMock.enable!
WebMock.disable_net_connect!

FIXTURES = File.expand_path('../spec/fixtures/open_weather', __dir__)

def stub_cassette(name)
  interaction = YAML.load_file(File.join(FIXTURES, "#{name}.yml"))['http_interactions'].first
  response = interaction['response']
  stub_request(interaction['request']['method'].to_sym, interaction['request']['uri']).to_return(
    status: response['status']['code'],
    headers: response['headers'].transform_values { |v| v.is_a?(Array) ? v.join(', ') : v },
    body: response['body']['string']
  )
end

%w[one_call/lat_lon forecast/hourly forecast/five_day forecast/thirty_day].each { |name| stub_cassette(name) }

client = OpenWeather::Client.new(api_key: 'api-key')

SCENARIOS = {
  'one_call' => -> { client.one_call(lat: 33.5312, lon: -111.9426) },
  'hourly' => -> { client.hourly(lat: 82.8628, lon: 135.0) },
  'five_day' => -> { client.five_day_forecast(lat: 51.5073, lon: -0.1277) },
  'thirty_day' => -> { client.thirty_day_forecast(lat: 33.5312, lon: -111.9426) }
}.freeze

selected = ARGV.empty? ? SCENARIOS.keys : ARGV
unknown = selected - SCENARIOS.keys
abort "Unknown scenario: #{unknown.join(', ')}. Use one of #{SCENARIOS.keys.join(', ')}." if unknown.any?

puts "Ruby #{RUBY_DESCRIPTION}"
puts "open-weather-ruby-client #{OpenWeather::VERSION}, hashie #{Hashie::VERSION}, faraday #{Faraday::VERSION}"
puts

puts 'Allocations per call:'
selected.each do |name|
  SCENARIOS[name].call
  GC.start
  before = GC.stat(:total_allocated_objects)
  SCENARIOS[name].call
  puts format('  %-12<name>s %<count>10d objects', name: name, count: GC.stat(:total_allocated_objects) - before)
end
puts

Benchmark.ips do |x|
  x.config(time: Integer(ENV.fetch('BENCHMARK_TIME', 5)), warmup: Integer(ENV.fetch('BENCHMARK_WARMUP', 2)))
  selected.each { |name| x.report(name, &SCENARIOS[name]) }
  x.save!(ENV['BENCHMARK_SAVE']) if ENV['BENCHMARK_SAVE']
  x.compare! if ENV['BENCHMARK_SAVE']
end
