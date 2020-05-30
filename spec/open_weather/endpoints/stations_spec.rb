# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'stations' do
  include_context 'API client'

  it 'registers a station', vcr: { cassette_name: 'stations/register_success' } do
    data = client.register_station(
      external_id: 'SF_TEST001',
      name: 'San Francisco Test Station',
      lat: 37.76,
      lon: -122.43,
      altitude: 150
    )
    expect(data).to have_attributes(
      external_id: 'SF_TEST001',
      name: 'San Francisco Test Station',
      lat: 37.76,
      lon: -122.43,
      altitude: 150
    )
  end
end
