# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'current_city_geo', vcr: { cassette_name: 'weather/weather_lat_lon' } do
  include_context 'API client'

  it 'returns city data by geo coordinates' do
    data = client.current_geo(51.51, -0.13)
    expect(data).to be_a OpenWeather::Models::City::Weather
    expect(data.id).to eq 2643743
    expect(data.name).to eq 'London'
  end
end
