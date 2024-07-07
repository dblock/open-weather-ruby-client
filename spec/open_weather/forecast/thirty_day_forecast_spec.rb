# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'thirty day forecast' do
  include_context 'API client'

  it 'mostly sunny', vcr: { cassette_name: 'forecast/thirty_day' } do
    data = client.thirty_day_forecast(lat: 33.5312, lon: -111.9426)

    expect(data).to be_a OpenWeather::Models::Forecast::ThirtyDay::ThirtyDay
    expect(data.cnt).to eq 29
    expect(data.city).to be_a OpenWeather::Models::Forecast::City

    expect(data.list).to be_a Array
    data.list.first.tap do |forecast|
      expect(forecast).to be_a OpenWeather::Models::Forecast::ThirtyDay::Forecast
      expect(forecast.dt).to be_a Time
      expect(forecast.sunrise).to be_a Time
      expect(forecast.sunset).to be_a Time
      expect(forecast.temp).to be_a OpenWeather::Models::Forecast::ThirtyDay::Temp
      expect(forecast.feels_like).to be_a OpenWeather::Models::OneCall::FeelsLike
      expect(forecast.pressure).to eq 1013
      expect(forecast.humidity).to eq 24
      expect(forecast.weather).to be_a Array
      expect(forecast.weather.first).to be_a OpenWeather::Models::Weather
      expect(forecast.speed).to eq 5.41
      expect(forecast.deg).to eq 241
      expect(forecast.clouds).to eq 78
      expect(forecast.rain).to be_nil
      expect(forecast.snow).to be_nil
    end
  end

  it 'snowy', vcr: { cassette_name: 'forecast/thirty_day' } do
    data = client.thirty_day_forecast(lat: 82.8628, lon: 135.0000)

    expect(data).to be_a OpenWeather::Models::Forecast::ThirtyDay::ThirtyDay
    expect(data.cnt).to eq 29
    expect(data.city).to be_a OpenWeather::Models::Forecast::City

    expect(data.list).to be_a Array
    data.list.first.tap do |forecast|
      expect(forecast).to be_a OpenWeather::Models::Forecast::ThirtyDay::Forecast
      expect(forecast.dt).to be_a Time
      expect(forecast.sunrise).to be_a Time
      expect(forecast.sunset).to be_a Time
      expect(forecast.temp).to be_a OpenWeather::Models::Forecast::ThirtyDay::Temp
      expect(forecast.feels_like).to be_a OpenWeather::Models::OneCall::FeelsLike
      expect(forecast.pressure).to eq 1011
      expect(forecast.humidity).to eq 93
      expect(forecast.weather).to be_a Array
      expect(forecast.weather.first).to be_a OpenWeather::Models::Weather
      expect(forecast.speed).to eq 3.5
      expect(forecast.deg).to eq 332
      expect(forecast.clouds).to eq 15
      expect(forecast.rain).to be_nil
      expect(forecast.snow).to eq 0.14
    end
  end

  it 'rainy', vcr: { cassette_name: 'forecast/thirty_day' } do
    data = client.thirty_day_forecast(lat: 39.00801, lon: -76.97647)

    expect(data).to be_a OpenWeather::Models::Forecast::ThirtyDay::ThirtyDay
    expect(data.cnt).to eq 30
    expect(data.city).to be_a OpenWeather::Models::Forecast::City

    expect(data.list).to be_a Array
    data.list.first.tap do |forecast|
      expect(forecast).to be_a OpenWeather::Models::Forecast::ThirtyDay::Forecast
      expect(forecast.dt).to be_a Time
      expect(forecast.sunrise).to be_a Time
      expect(forecast.sunset).to be_a Time
      expect(forecast.temp).to be_a OpenWeather::Models::Forecast::ThirtyDay::Temp
      expect(forecast.feels_like).to be_a OpenWeather::Models::OneCall::FeelsLike
      expect(forecast.pressure).to eq 1012
      expect(forecast.humidity).to eq 48
      expect(forecast.weather).to be_a Array
      expect(forecast.weather.first).to be_a OpenWeather::Models::Weather
      expect(forecast.speed).to eq 4.88
      expect(forecast.deg).to eq 196
      expect(forecast.clouds).to eq 61
      expect(forecast.rain).to eq 0.51
      expect(forecast.snow).to be_nil
    end
  end
end
