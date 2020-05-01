# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'OpenWeather::Client#circle' do
  include_context 'API client'

  context 'without cluster', vcr: { cassette_name: 'weather/cities_circle' } do
    it 'returns data' do
      data = client.cities_circle(55.5, 37.5, 7)
      expect(data).to be_a OpenWeather::Models::List
      expect(data.cnt).to eq 7
      city = data.first
      expect(city.name).to eq 'Shcherbinka'
      expect(city.main.temp).to eq 276.86
      expect(data.map(&:name).size).to eq 7
    end
    it 'returns data with named arguments' do
      data = client.cities_circle(lat: 55.5, lon: 37.5, cnt: 7)
      expect(data).to be_a OpenWeather::Models::List
      expect(data.cnt).to eq 7
      city = data.first
      expect(city.name).to eq 'Shcherbinka'
    end
  end
end
