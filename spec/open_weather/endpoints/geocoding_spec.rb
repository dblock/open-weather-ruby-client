# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OpenWeather::Endpoints::Geocoding do
  include_context 'API client'

  describe '#geo_direct' do
    it 'returns geo locations for a city name', vcr: { cassette_name: 'geocoding/geo_direct_success' } do
      data = client.geo_direct('London', nil, 'GB')
      expect(data).to be_a(Array)
      expect(data.size).to eq(1)
      expect(data.first).to be_a(OpenWeather::Models::GeoLocation)
      expect(data.first).to have_attributes(
        name: 'London',
        lat: 51.5074456,
        lon: -0.1277653,
        country: 'GB',
        state: 'England'
      )
      expect(data.first.local_names['en']).to eq('London')
    end

    it 'accepts a hash of options', vcr: { cassette_name: 'geocoding/geo_direct_success' } do
      data = client.geo_direct(city: 'London', country: 'GB')
      expect(data.first).to have_attributes(name: 'London')
    end
  end

  describe '#geo_reverse' do
    it 'returns geo locations for coordinates', vcr: { cassette_name: 'geocoding/geo_reverse_success' } do
      data = client.geo_reverse(51.5073219, -0.1276474)
      expect(data).to be_a(Array)
      expect(data.size).to eq(1)
      expect(data.first).to be_a(OpenWeather::Models::GeoLocation)
      expect(data.first).to have_attributes(
        name: 'City of Westminster',
        lat: 51.4973206,
        lon: -0.137149,
        country: 'GB',
        state: 'England'
      )
    end

    it 'accepts a hash of options', vcr: { cassette_name: 'geocoding/geo_reverse_success' } do
      data = client.geo_reverse(lat: 51.5073219, lon: -0.1276474)
      expect(data.first).to have_attributes(name: 'City of Westminster')
    end
  end

  describe '#geo_zip' do
    it 'returns a geo location for a zip code', vcr: { cassette_name: 'geocoding/geo_zip_success' } do
      data = client.geo_zip('94040', 'US')
      expect(data).to be_a(OpenWeather::Models::GeoLocationZip)
      expect(data).to have_attributes(
        zip: '94040',
        name: 'Mountain View',
        lat: 37.3855,
        lon: -122.088,
        country: 'US'
      )
    end

    it 'accepts a hash of options', vcr: { cassette_name: 'geocoding/geo_zip_success' } do
      data = client.geo_zip(zip: '94040', country: 'US')
      expect(data).to have_attributes(name: 'Mountain View')
    end
  end
end
