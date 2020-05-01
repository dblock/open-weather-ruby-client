# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'config.metric' do
  include_context 'API client'

  it 'retrieves city names in Russian with metric units', vcr: { cassette_name: 'weather/weather_id_ru_metric' } do
    data = client.current_weather(id: 524901, lang: 'ru', units: 'metric')
    expect(data).to be_a OpenWeather::Models::Data
    expect(data.id).to eq 524901
    expect(data.name).to eq 'Москва'
    expect(data.main.temp).to eq 12
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
      expect(data).to be_a OpenWeather::Models::Data
      expect(data.id).to eq 524901
      expect(data.name).to eq 'Москва'
      expect(data.main.temp).to eq 12
    end
    it 'can be overridden', vcr: { cassette_name: 'weather/weather_id_ru_imperial' } do
      data = client.current_weather(id: 524901, units: 'imperial')
      expect(data).to be_a OpenWeather::Models::Data
      expect(data.id).to eq 524901
      expect(data.name).to eq 'Москва'
      expect(data.main.temp).to eq 53.6
    end
  end
end
