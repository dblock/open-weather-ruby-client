# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'config.metric' do
  include_context 'API client'

  it 'retrieves city names in Russian with metric units', vcr: { cassette_name: 'weather/weather_id_ru_metric' } do
    data = client.current_weather(id: 524901, lang: 'ru', units: 'metric')
    expect(data).to be_a OpenWeather::Models::City::Weather
    expect(data.id).to eq 524901
    expect(data.name).to eq 'Москва'
    expect(data.main.temp).to eq 12
    expect(data.main.temp_c).to eq 12
    expect(data.main.temp_k).to eq 285.15
    expect(data.main.temp_f).to eq 53.6
  end
  it 'retrieves city names in Russian with imperial units', vcr: { cassette_name: 'weather/weather_id_ru_imperial' } do
    data = client.current_weather(id: 524901, lang: 'ru', units: 'imperial')
    expect(data).to be_a OpenWeather::Models::City::Weather
    expect(data.id).to eq 524901
    expect(data.name).to eq 'Москва'
    expect(data.main.temp).to eq 53.6
    expect(data.main.temp_c).to eq 12
    expect(data.main.temp_k).to eq 285.15
    expect(data.main.temp_f).to eq 53.6
  end
  context 'set globally' do
    before do
      OpenWeather.configure do |config|
        config.lang = 'ru'
        config.units = 'metric'
      end
    end
    it 'retrieves city names in Russian with metric units', vcr: { cassette_name: 'weather/weather_id_ru_metric' } do
      data = client.current_weather(id: 524901)
      expect(data).to be_a OpenWeather::Models::City::Weather
      expect(data.id).to eq 524901
      expect(data.name).to eq 'Москва'
      expect(data.main.temp).to eq 12
      expect(data.main.temp_c).to eq 12
      expect(data.main.temp_k).to eq 285.15
      expect(data.main.temp_f).to eq 53.6
    end
    it 'can be overridden', vcr: { cassette_name: 'weather/weather_id_ru_imperial' } do
      data = client.current_weather(id: 524901, units: 'imperial')
      expect(data).to be_a OpenWeather::Models::City::Weather
      expect(data.id).to eq 524901
      expect(data.name).to eq 'Москва'
      expect(data.main.temp).to eq 53.6
      expect(data.main.temp_c).to eq 12
      expect(data.main.temp_k).to eq 285.15
      expect(data.main.temp_f).to eq 53.6
    end
  end
end
