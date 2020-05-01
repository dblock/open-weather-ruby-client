# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'config.lang' do
  include_context 'API client'

  it 'retrieves city names in Russian', vcr: { cassette_name: 'weather/weather_id_ru' } do
    data = client.current_weather(id: 2643743, lang: 'ru')
    expect(data).to be_a OpenWeather::Models::CityWeather
    expect(data.id).to eq 2643743
    expect(data.name).to eq 'Лондон'
  end
  context 'set globally' do
    before do
      OpenWeather.configure do |config|
        config.lang = 'ru'
      end
    end
    it 'retrieves city names in Russian', vcr: { cassette_name: 'weather/weather_id_ru' } do
      data = client.current_weather(id: 2643743)
      expect(data).to be_a OpenWeather::Models::CityWeather
      expect(data.id).to eq 2643743
      expect(data.name).to eq 'Лондон'
    end
    it 'can be overridden', vcr: { cassette_name: 'weather/weather_id_en' } do
      data = client.current_weather(id: 2643743, lang: 'en')
      expect(data).to be_a OpenWeather::Models::CityWeather
      expect(data.id).to eq 2643743
      expect(data.name).to eq 'London'
    end
  end
end
