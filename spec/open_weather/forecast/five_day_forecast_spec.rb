# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'five day forecast' do
  include_context 'API client'

  it 'mostly sunny', vcr: { cassette_name: 'forecast/five_day' } do
    data = client.five_day_forecast(lat: 51.5073, lon: -0.1277)
    expect(data).to be_a OpenWeather::Models::Forecast::FiveDay::FiveDay
    expect(data.cod).to eq('200')
    expect(data.cnt).to eq(40)
    expect(data.list).to be_a Array

    data.list.first.tap do |forecast|
      expect(forecast).to be_a OpenWeather::Models::Forecast::FiveDay::Forecast
      expect(forecast.dt).to be_a Time
      expect(forecast.main).to be_a OpenWeather::Models::Main
      expect(forecast.main.temp).to eq 288.02
      expect(forecast.main.feels_like).to eq 287.21
      expect(forecast.main.pressure).to eq 1017
      expect(forecast.main.humidity).to eq 63
      expect(forecast.weather).to be_a Array
      expect(forecast.weather.first).to be_a OpenWeather::Models::Weather
      expect(forecast.clouds).to be_a OpenWeather::Models::Clouds
      expect(forecast.clouds.all).to eq 33
      expect(forecast.wind).to be_a OpenWeather::Models::Wind
      expect(forecast.wind.speed).to eq 3.01
      expect(forecast.wind.deg).to eq 107
      expect(forecast.visibility).to eq 10000
      expect(forecast.pop).to eq 0
      forecast.dt.to_s
      expect(forecast.dt_txt).to eq forecast.dt.strftime('%Y-%m-%d %H:%M:%S')
    end
  end

  it 'rainy', vcr: { cassette_name: 'forecast/five_day' } do
    data = client.five_day_forecast(lat: 39.00801, lon: -76.97647)
    expect(data).to be_a OpenWeather::Models::Forecast::FiveDay::FiveDay
    expect(data.cod).to eq('200')
    expect(data.list).to be_a Array

    data.list.first.tap do |forecast|
      expect(forecast).to be_a OpenWeather::Models::Forecast::FiveDay::Forecast
      expect(forecast.dt).to be_a Time
      expect(forecast.main).to be_a OpenWeather::Models::Main
      expect(forecast.main.temp).to eq 293.69
      expect(forecast.main.pressure).to eq 1000
      expect(forecast.main.humidity).to eq 53
      expect(forecast.weather).to be_a Array
      expect(forecast.weather.first).to be_a OpenWeather::Models::Weather
      expect(forecast.wind.speed).to eq 2.48
      expect(forecast.wind.deg).to eq 252
      expect(forecast.clouds.all).to eq 33
      expect(forecast.rain).to be_a OpenWeather::Models::Rain
      expect(forecast.snow).to be_nil
    end
  end

  it 'snowy', vcr: { cassette_name: 'forecast/five_day' } do
    data = client.five_day_forecast(lat: -82.713066, lon: 3.877213)
    expect(data).to be_a OpenWeather::Models::Forecast::FiveDay::FiveDay
    expect(data.cod).to eq('200')
    expect(data.list).to be_a Array

    data.list.first.tap do |forecast|
      expect(forecast).to be_a OpenWeather::Models::Forecast::FiveDay::Forecast
      expect(forecast.dt).to be_a Time
      expect(forecast.main).to be_a OpenWeather::Models::Main
      expect(forecast.main.temp).to eq 245.97
      expect(forecast.main.feels_like).to eq 238.97
      expect(forecast.main.pressure).to eq 995
      expect(forecast.main.humidity).to eq 100
      expect(forecast.weather).to be_a Array
      expect(forecast.weather.first).to be_a OpenWeather::Models::Weather
      expect(forecast.wind.speed).to eq 3.34
      expect(forecast.wind.deg).to eq 1
      expect(forecast.clouds.all).to eq 100
      expect(forecast.rain).to be_nil
      expect(forecast.snow).to be_a OpenWeather::Models::Snow
    end
  end
end
