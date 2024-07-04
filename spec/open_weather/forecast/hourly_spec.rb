# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'hourly forecast without rain or snow' do
  include_context 'API client'

  it 'hourly mostly sunny', vcr: { cassette_name: 'forecast/hourly' } do
    data = client.hourly(lat: 82.8628, lon: 135.0000)

    expect(data).to be_a OpenWeather::Models::Forecast::Hourly
    expect(data.cnt).to eq 96
    expect(data.city).to be_a OpenWeather::Models::Forecast::City

    expect(data.list).to be_a Array
    data.list.first.tap do |forecast|
      expect(forecast).to be_a OpenWeather::Models::Forecast::Forecast
      expect(forecast.dt).to be_a Time
      expect(forecast.main).to be_a OpenWeather::Models::Main
      expect(forecast.weather).to be_a Array
      expect(forecast.weather.first).to be_a OpenWeather::Models::Weather
      expect(forecast.clouds).to be_a OpenWeather::Models::Clouds
      expect(forecast.wind).to be_a OpenWeather::Models::Wind
      expect(forecast.rain).to be_nil
      expect(forecast.snow).to be_nil
      expect(forecast.visibility).to eq 2686
      expect(forecast.pop).to eq 0.0
      expect(forecast.sys).to be_a OpenWeather::Models::Sys
      expect(forecast.dt_txt).to eq '2024-07-04 19:00:00'
    end
  end

  it 'hourly with rain', vcr: { cassette_name: 'forecast/hourly' } do
    data = client.hourly(lat: 82.8628, lon: 135.0000)

    expect(data).to be_a OpenWeather::Models::Forecast::Hourly
    expect(data.cnt).to eq 96
    expect(data.city).to be_a OpenWeather::Models::Forecast::City

    expect(data.list).to be_a Array
    data.list[64].tap do |forecast|
      expect(forecast).to be_a OpenWeather::Models::Forecast::Forecast
      expect(forecast.dt).to be_a Time
      expect(forecast.main).to be_a OpenWeather::Models::Main
      expect(forecast.weather).to be_a Array
      expect(forecast.weather.first).to be_a OpenWeather::Models::Weather
      expect(forecast.clouds).to be_a OpenWeather::Models::Clouds
      expect(forecast.wind).to be_a OpenWeather::Models::Wind
      expect(forecast.rain).to be_a OpenWeather::Models::Rain
      expect(forecast.snow).to be_nil
      expect(forecast.visibility).to eq 10000
      expect(forecast.pop).to eq 0.69
      expect(forecast.sys).to be_a OpenWeather::Models::Sys
      expect(forecast.dt_txt).to eq '2024-07-07 11:00:00'
    end
  end

  it 'hourly with snow', vcr: { cassette_name: 'forecast/hourly' } do
    data = client.hourly(lat: -70.86960, lon: -75.11441)

    expect(data).to be_a OpenWeather::Models::Forecast::Hourly
    expect(data.cnt).to eq 96
    expect(data.city).to be_a OpenWeather::Models::Forecast::City

    expect(data.list).to be_a Array
    data.list[1].tap do |forecast|
      expect(forecast).to be_a OpenWeather::Models::Forecast::Forecast
      expect(forecast.dt).to be_a Time
      expect(forecast.main).to be_a OpenWeather::Models::Main
      expect(forecast.weather).to be_a Array
      expect(forecast.weather.first).to be_a OpenWeather::Models::Weather
      expect(forecast.clouds).to be_a OpenWeather::Models::Clouds
      expect(forecast.wind).to be_a OpenWeather::Models::Wind
      expect(forecast.rain).to be_nil
      expect(forecast.snow).to be_a OpenWeather::Models::Snow
      expect(forecast.visibility).to eq 105
      expect(forecast.pop).to eq 1.0
      expect(forecast.sys).to be_a OpenWeather::Models::Sys
      expect(forecast.dt_txt).to eq '2024-07-04 20:00:00'
    end
  end
end
