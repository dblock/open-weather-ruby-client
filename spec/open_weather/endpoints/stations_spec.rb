# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OpenWeather::Endpoints::Stations do
  include_context 'API client', endpoint: 'https://api.openweathermap.org/data/3.0'

  describe '#register_station' do
    it 'registers a station', vcr: { cassette_name: 'stations/register_success' } do
      data = client.register_station(
        external_id: 'SF_TEST001',
        name: 'San Francisco Test Station',
        latitude: 37.76,
        longitude: -122.43,
        altitude: 150
      )
      expect(data).to be_a(OpenWeather::Models::Station)
      expect(data).to have_attributes(
        id: '5ed21a12cca8ce0001f1aef1',
        external_id: 'SF_TEST001',
        name: 'San Francisco Test Station',
        latitude: 37.76,
        longitude: -122.43,
        altitude: 150
      )
    end
  end

  describe '#list_stations' do
    it 'registers a station', vcr: { cassette_name: 'stations/list_stations_success' } do
      data = client.list_stations
      expect(data).to be_a(Array)
      expect(data.size).to eq(2)
      expect(data.first).to be_a(OpenWeather::Models::Station)
      expect(data.first).to have_attributes(
        id: '5ed21311cca8ce0001f1aef0',
        external_id: 'SF_TEST001',
        name: 'San Francisco Test Station',
        latitude: 37.76,
        longitude: -122.43,
        altitude: 150
      )
    end
  end
end
