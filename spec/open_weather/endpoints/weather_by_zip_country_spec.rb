# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'OpenWeather::Client#weather', vcr: { cassette_name: 'weather/zip_country' } do
  include_context 'API client'

  context 'by zip and country' do
    it 'weather' do
      data = client.weather(zip: 10_018, country: 'US')
      expect(data).to be_a OpenWeather::Models::Data
      expect(data.name).to eq 'New York'
    end
    it 'zip' do
      data = client.zip(10_018, 'US')
      expect(data).to be_a OpenWeather::Models::Data
      expect(data.name).to eq 'New York'
    end
  end
end
