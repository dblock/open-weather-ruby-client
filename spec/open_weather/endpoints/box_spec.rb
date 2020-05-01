# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'OpenWeather::Client#box' do
  include_context 'API client'

  context 'without cluster', vcr: { cassette_name: 'weather/bbox_city' } do
    it 'returns data with named args' do
      data = client.cities_box(12, 32, 15, 37, 10)
      expect(data).to be_a OpenWeather::Models::List
      expect(data.cnt).to eq 15
      city = data.first
      expect(city.name).to eq 'Birkirkara'
      expect(city.main.temp).to eq 16.23
      expect(data.map(&:name).size).to eq 15
    end
    it 'returns data with coordinates' do
      data = client.cities_box(lon_left: 12, lat_bottom: 32, lon_right: 15, lat_top: 37, zoom: 10)
      expect(data).to be_a OpenWeather::Models::List
      expect(data.cnt).to eq 15
    end
  end
  context 'with cluster', vcr: { cassette_name: 'weather/bbox_city_cluster' } do
    it 'returns data with named args' do
      data = client.cities_box(12, 32, 15, 37, 10, cluster: true)
      expect(data).to be_a OpenWeather::Models::List
      expect(data.cnt).to eq 15
    end
    it 'returns data with coordinates' do
      data = client.cities_box(lon_left: 12, lat_bottom: 32, lon_right: 15, lat_top: 37, zoom: 10, cluster: true)
      expect(data).to be_a OpenWeather::Models::List
      expect(data.cnt).to eq 15
    end
  end
end
