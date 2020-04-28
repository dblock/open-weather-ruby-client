# frozen_string_literal: true

RSpec.shared_context 'API client', shared_context: :metadata do
  before do
    OpenWeather::Config.reset
  end
  let(:client) { OpenWeather::Client.new(api_key: ENV['OPEN_WEATHER_API_KEY'] || 'api-key') }
end
