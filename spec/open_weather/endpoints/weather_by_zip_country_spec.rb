# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'OpenWeather::Client#weather' do
  include_context 'API client'
  it 'gets current weather by zip and country', vcr: { cassette_name: 'weather/zip_country' } do
    data = client.weather(zip: 10_018, country: 'US')
    expect(data).to be_a OpenWeather::Models::Data
    expect(data.name).to eq 'New York'
  end
end
