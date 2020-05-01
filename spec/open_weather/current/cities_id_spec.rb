# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'current_cities_id' do
  include_context 'API client'

  it 'returns weather in multiple cities', vcr: { cassette_name: 'weather/group' } do
    data = client.current_cities_id(524901, 703448, 2643743)
    expect(data).to be_a OpenWeather::Models::List
    expect(data.cnt).to eq 3
    expect(data.map(&:name).size).to eq 3
    city = data.first
    expect(city.name).to eq 'Moscow'
    expect(city.main.temp).to eq 285.15
  end
  it 'returns weather in multiple cities in metric units', vcr: { cassette_name: 'weather/group_metric' } do
    data = client.current_cities_id(524901, 703448, 2643743, { units: 'metric' })
    expect(data).to be_a OpenWeather::Models::List
    expect(data.cnt).to eq 3
    expect(data.map(&:name).size).to eq 3
    city = data.first
    expect(city.name).to eq 'Moscow'
    expect(city.main.temp).to eq 12
  end
  it 'returns weather in multiple cities with named id', vcr: { cassette_name: 'weather/group_metric' } do
    data = client.current_cities_id(id: [524901, 703448, 2643743], units: 'metric')
    expect(data).to be_a OpenWeather::Models::List
    expect(data.cnt).to eq 3
    city = data.first
    expect(city.name).to eq 'Moscow'
  end
  it 'returns weather in multiple cities with named ids', vcr: { cassette_name: 'weather/group_metric' } do
    data = client.current_cities_id(ids: [524901, 703448, 2643743], units: 'metric')
    expect(data).to be_a OpenWeather::Models::List
    expect(data.cnt).to eq 3
    city = data.first
    expect(city.name).to eq 'Moscow'
  end
end
