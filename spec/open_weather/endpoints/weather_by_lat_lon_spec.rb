# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'OpenWeather::Client#weather' do
  include_context 'API client'
  it 'gets current weather by lat and lon', vcr: { cassette_name: 'weather/lat_lon' } do
    data = client.weather(lat: 51.51, lon: -0.13)
    expect(data).to be_a OpenWeather::Models::Data
    expect(data.id).to eq 2_643_743
    expect(data.name).to eq 'London'
  end
end
