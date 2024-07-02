# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'hourly forecast' do
  include_context 'API client'

  it 'hourly', vcr: { cassette_name: 'forecast/hourly' } do
    data = client.hourly(lat: 33.5312, lon: -111.9426)

    expect(data).to be_a OpenWeather::Models::Forecast::Hourly
    expect(data.cnt).to eq 96
    expect(data.city).to be_a OpenWeather::Models::Forecast::City

    expect(data.list).to be_a Array
    data.list.first.tap do |forecast|
      expect(forecast).to be_a OpenWeather::Models::Forecast::Forecast
      expect(forecast.dt).to eq Time.at(1661875200)
      expect(forecast.main).to be_a OpenWeather::Models::Main
      expect(forecast.weather).to be_a Array
      expect(forecast.weather.first).to be_a OpenWeather::Models::Weather
      expect(forecast.clouds).to be_a OpenWeather::Models::Clouds
      expect(forecast.wind).to be_a OpenWeather::Models::Wind
      expect(forecast.rain).to be_a OpenWeather::Models::Rain
      expect(forecast.snow).to be_nil
      expect(forecast.visibility).to eq 10000
      expect(forecast.pop).to eq 0.32
      expect(forecast.sys).to be_a OpenWeather::Models::Sys
      expect(forecast.dt_txt).to eq '2022-08-30 16:00:00'
    end
  end
end
