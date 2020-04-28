# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'OpenWeather::Client#weather' do
  include_context 'API client'
  it 'gets current weather by city id', vcr: { cassette_name: 'weather/city_id' } do
    data = client.weather(id: 2_643_743)
    expect(data).to be_a OpenWeather::Models::Data
    expect(data.id).to eq 2_643_743
    expect(data.name).to eq 'London'
  end
end
