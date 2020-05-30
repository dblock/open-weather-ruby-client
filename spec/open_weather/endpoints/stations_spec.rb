# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'stations' do
  include_context 'API client'

  it 'registers a station', vcr: { cassette_name: 'stations/register_success' } do
    client.endpoint = 'https://api.openweathermap.org/data/3.0'
    data = client.register_station(
      external_id: 'SF_TEST001',
      name: 'San Francisco Test Station',
      latitude: 37.76,
      longitude: -122.43,
      altitude: 150
    )
    expect(data).to be_a(OpenWeather::Models::Station)
    expect(data).to have_attributes(
      external_id: 'SF_TEST001',
      name: 'San Francisco Test Station',
      latitude: 37.76,
      longitude: -122.43,
      altitude: 150
    )
  end
end
