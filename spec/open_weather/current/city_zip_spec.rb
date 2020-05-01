# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'current_zip', vcr: { cassette_name: 'weather/weather_zip' } do
  include_context 'API client'

  it 'returns current weather in zip' do
    data = client.current_zip(10018, 'US')
    expect(data).to be_a OpenWeather::Models::Data
    expect(data.name).to eq 'New York'
  end
end
