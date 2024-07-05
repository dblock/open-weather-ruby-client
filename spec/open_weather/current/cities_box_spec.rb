# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'current_cities_geo_box' do
  include_context 'API client'

  context 'without cluster', vcr: { cassette_name: 'weather/box_city' } do
    it 'returns cities in a box weather with named args' do
      data = client.current_cities_geo_box(12, 32, 15, 37, 10)
      expect(data).to be_a OpenWeather::Models::List
      expect(data.cnt).to eq 15
      city = data.first
      expect(city.name).to eq 'Birkirkara'
      expect(city.main.temp).to eq 16.23
      expect(data.map(&:name).size).to eq 15
    end
    it 'returns cities in a box weather with named coordinates' do
      data = client.current_cities_geo_box(lon_left: 12, lat_bottom: 32, lon_right: 15, lat_top: 37, zoom: 10)
      expect(data).to be_a OpenWeather::Models::List
      expect(data.cnt).to eq 15
    end
  end
  context 'with cluster', vcr: { cassette_name: 'weather/box_city_cluster' } do
    it 'returns cities in a box weather with named args' do
      data = client.current_cities_geo_box(12, 32, 15, 37, 10, cluster: true)
      expect(data).to be_a OpenWeather::Models::List
      expect(data.cnt).to eq 15
    end
    it 'returns cities in a box weather with coordinates' do
      data = client.current_cities_geo_box(
        lon_left: 12, lat_bottom: 32, lon_right: 15, lat_top: 37, zoom: 10, cluster: true
      )
      expect(data).to be_a OpenWeather::Models::List
      expect(data.cnt).to eq 15
    end
  end
end
