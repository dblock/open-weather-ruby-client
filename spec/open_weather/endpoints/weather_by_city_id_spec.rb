# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'OpenWeather::Client#weather', vcr: { cassette_name: 'weather/city_id' } do
  include_context 'API client'

  context 'city id' do
    it 'weather' do
      data = client.weather(id: 2_643_743)
      expect(data).to be_a OpenWeather::Models::Data
      expect(data.id).to eq 2_643_743
      expect(data.name).to eq 'London'
    end
    it 'id' do
      data = client.id(2_643_743)
      expect(data).to be_a OpenWeather::Models::Data
      expect(data.id).to eq 2_643_743
      expect(data.name).to eq 'London'
    end
  end
end
