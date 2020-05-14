# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'current_city_name', vcr: { cassette_name: 'weather/weather_name' } do
  include_context 'API client'

  it 'returns current weather in a city by name' do
    data = client.current_city('London')
    expect(data).to be_a OpenWeather::Models::City::Weather
    expect(data.name).to eq 'London'
    expect(data.base).to eq 'stations'
    expect(data.clouds.all).to eq 100
    expect(data.cod).to eq 200
    expect(data.coord.lat).to eq 51.51
    expect(data.coord.lon).to eq(-0.13)
    expect(data.dt).to eq Time.parse('2020-04-27 23:26:08 -0400')
    expect(data.id).to eq 2643743
    expect(data.main.feels_like).to eq 277.73
    expect(data.main.humidity).to eq 81
    expect(data.main.pressure).to eq 1005
    expect(data.main.temp).to eq 282.57
    expect(data.main.temp_max).to eq 283.15
    expect(data.main.temp_min).to eq 281.48
    expect(data.name).to eq 'London'
    expect(data.rain['1h']).to eq 0.51
    expect(data.sys.id).to eq 1414
    expect(data.sys.country).to eq 'GB'
    expect(data.sys.sunrise).to eq Time.parse('2020-04-28 04:37:13 UTC')
    expect(data.sys.sunset).to eq Time.parse('2020-04-28 19:18:26 UTC')
    expect(data.sys.type).to eq 1
    expect(data.timezone).to eq 3600
    expect(data.visibility).to eq 10_000
    expect(data.weather.size).to eq 1
    expect(data.weather[0].description).to eq 'light rain'
    expect(data.weather[0].icon).to eq '10n'
    expect(data.weather[0].id).to eq 500
    expect(data.weather[0].main).to eq 'Rain'
    expect(data.wind.deg).to eq 70
    expect(data.wind.speed).to eq 5.7
  end
end
