# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'OpenWeather::Config#lang', vcr: { cassette_name: 'weather/city_id_ru' } do
  include_context 'API client'

  context 'city id with lang' do
    it 'retrieves city names in Russian' do
      data = client.weather(id: 2_643_743, lang: 'ru')
      expect(data).to be_a OpenWeather::Models::Data
      expect(data.id).to eq 2_643_743
      expect(data.name).to eq 'Лондон'
    end
  end
  context 'global config' do
    before do
      OpenWeather.configure do |config|
        config.lang = 'ru'
      end
    end
    it 'retrieves city names in Russian' do
      data = client.weather(id: 2_643_743, lang: 'ru')
      expect(data).to be_a OpenWeather::Models::Data
      expect(data.id).to eq 2_643_743
      expect(data.name).to eq 'Лондон'
    end
  end
end
