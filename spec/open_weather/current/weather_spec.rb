# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'weather' do
  include_context 'API client'

  it 'lat, lon', vcr: { cassette_name: 'weather/weather_lat_lon' } do
    data = client.current_weather(lat: 51.51, lon: -0.13)
    expect(data).to be_a OpenWeather::Models::Data
    expect(data.id).to eq 2643743
    expect(data.name).to eq 'London'
  end
  it 'id', vcr: { cassette_name: 'weather/weather_id' } do
    data = client.current_weather(id: 2643743)
    expect(data).to be_a OpenWeather::Models::Data
    expect(data.id).to eq 2643743
    expect(data.name).to eq 'London'
  end
  it 'city', vcr: { cassette_name: 'weather/weather_name' } do
    data = client.current_weather(city: 'London')
    expect(data).to be_a OpenWeather::Models::Data
    expect(data.name).to eq 'London'
  end
  it 'city, state, country', vcr: { cassette_name: 'weather/weather_name_state_country' } do
    data = client.current_weather(city: 'New York', state: 'NY', country: 'US')
    expect(data).to be_a OpenWeather::Models::Data
    expect(data.name).to eq 'New York'
  end
  it 'zip, country', vcr: { cassette_name: 'weather/weather_zip' } do
    data = client.current_weather(zip: 10018, country: 'US')
    expect(data).to be_a OpenWeather::Models::Data
    expect(data.name).to eq 'New York'
  end
end
