# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'current_city_id', vcr: { cassette_name: 'weather/weather_id' } do
  include_context 'API client'

  it 'returns current weather in city with named id parameter' do
    data = client.current_city_id(id: 2643743)
    expect(data).to be_a OpenWeather::Models::City::Weather
    expect(data.id).to eq 2643743
    expect(data.name).to eq 'London'
  end
  it 'returns current weather in city' do
    data = client.current_city_id(2643743)
    expect(data).to be_a OpenWeather::Models::City::Weather
    expect(data.id).to eq 2643743
    expect(data.name).to eq 'London'
  end
end
