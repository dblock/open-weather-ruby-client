# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'current_cities_geo_circle', vcr: { cassette_name: 'weather/find' } do
  include_context 'API client'

  it 'cities around a center' do
    data = client.current_cities_geo_circle(55.5, 37.5, 7)
    expect(data).to be_a OpenWeather::Models::List
    expect(data.cnt).to eq 7
    city = data.first
    expect(city.name).to eq 'Shcherbinka'
    expect(city.main.temp).to eq 276.86
    expect(data.map(&:name).size).to eq 7
  end
  it 'returns cities around a center with named arguments' do
    data = client.current_cities_geo_circle(lat: 55.5, lon: 37.5, cnt: 7)
    expect(data).to be_a OpenWeather::Models::List
    expect(data.cnt).to eq 7
    city = data.first
    expect(city.name).to eq 'Shcherbinka'
  end
end
