# frozen_string_literal: true

RSpec.shared_context 'API client', shared_context: :metadata do |params|
  before do
    OpenWeather::Config.reset
    OpenWeather::Config.endpoint = params[:endpoint] if params&.key?(:endpoint)
  end
  let(:client) { OpenWeather::Client.new(api_key: ENV['OPEN_WEATHER_API_KEY'] || 'api-key') }
end
