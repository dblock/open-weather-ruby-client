# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'current_city', vcr: { cassette_name: 'weather/weather_name_state_country' } do
  include_context 'API client'

  it 'returns data in a city by name, state and country' do
    data = client.current_city('New York', 'NY', 'US')
    expect(data).to be_a OpenWeather::Models::City::Weather
    expect(data.name).to eq 'New York'
    expect(data.base).to eq 'stations'
    expect(data.clouds.all).to eq 90
    expect(data.cod).to eq 200
    expect(data.coord.lat).to eq 40.71
    expect(data.coord.lon).to eq(-74.01)
    expect(data.dt).to eq Time.parse('2020-04-28 03:49:45 UTC')
    expect(data.id).to eq 5_128_581
    expect(data.main.feels_like).to eq 276.82
    expect(data.main.humidity).to eq 75
    expect(data.main.pressure).to eq 1019
    expect(data.main.temp).to eq 279.86
    expect(data.main.temp_max).to eq 280.37
    expect(data.main.temp_min).to eq 279.26
    expect(data.name).to eq 'New York'
    expect(data.rain).to be nil
    expect(data.sys.id).to eq 4610
    expect(data.sys.country).to eq 'US'
    expect(data.sys.sunrise).to eq Time.parse('2020-04-27 09:59:06 UTC')
    expect(data.sys.sunset).to eq Time.parse('2020-04-27 23:47:49 UTC')
    expect(data.sys.type).to eq 1
    expect(data.timezone).to eq(-14_400)
    expect(data.visibility).to eq 16_093
    expect(data.weather.size).to eq 1
    expect(data.weather[0].description).to eq 'overcast clouds'
    expect(data.weather[0].icon).to eq '04n'
    expect(data.weather[0].id).to eq 804
    expect(data.weather[0].main).to eq 'Clouds'
    expect(data.wind.deg).to be nil
    expect(data.wind.speed).to eq 2.1
  end
end
