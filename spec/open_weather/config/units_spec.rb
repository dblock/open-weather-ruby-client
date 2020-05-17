# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'config.metric' do
  include_context 'API client'

  context 'metric Russian', vcr: { cassette_name: 'weather/weather_id_ru_metric' } do
    subject do
      client.current_weather(id: 524901, lang: 'ru', units: 'metric')
    end
    it 'retrieves city names in Russian' do
      expect(subject).to be_a OpenWeather::Models::City::Weather
      expect(subject.id).to eq 524901
      expect(subject.name).to eq 'Москва'
    end
    it 'converts temperature from celcius' do
      expect(subject.main.temp).to eq 12
      expect(subject.main.temp_c).to eq 12
      expect(subject.main.temp_k).to eq 285.15
      expect(subject.main.temp_f).to eq 53.6
    end
    it 'converts wind speed from meters per second' do
      expect(subject.wind.speed).to eq 3
      expect(subject.wind.speed_mph).to eq 6.71
      expect(subject.wind.speed_mps).to eq 3
    end
  end
  context 'imperial Russian', vcr: { cassette_name: 'weather/weather_id_ru_imperial' } do
    subject do
      client.current_weather(id: 524901, lang: 'ru', units: 'imperial')
    end
    it 'retrieves city names in Russian' do
      expect(subject).to be_a OpenWeather::Models::City::Weather
      expect(subject.id).to eq 524901
      expect(subject.name).to eq 'Москва'
    end
    it 'converts temperature from farenheit' do
      expect(subject.main.temp).to eq 53.6
      expect(subject.main.temp_c).to eq 12
      expect(subject.main.temp_k).to eq 285.15
      expect(subject.main.temp_f).to eq 53.6
    end
    it 'converts wind speed from meters per second' do
      expect(subject.wind.speed).to eq 6.71
      expect(subject.wind.speed_mph).to eq 6.71
      expect(subject.wind.speed_mps).to eq 3
    end
  end
  context 'set globally' do
    before do
      OpenWeather.configure do |config|
        config.lang = 'ru'
        config.units = 'metric'
      end
    end
    context 'metric Russian', vcr: { cassette_name: 'weather/weather_id_ru_metric' } do
      subject do
        client.current_weather(id: 524901)
      end
      it 'retrieves city names in Russian' do
        expect(subject).to be_a OpenWeather::Models::City::Weather
        expect(subject.id).to eq 524901
        expect(subject.name).to eq 'Москва'
      end
      it 'converts temperature from celcius' do
        expect(subject.main.temp).to eq 12
        expect(subject.main.temp_c).to eq 12
        expect(subject.main.temp_k).to eq 285.15
        expect(subject.main.temp_f).to eq 53.6
      end
      it 'converts wind speed from meters per second' do
        expect(subject.wind.speed).to eq 3
        expect(subject.wind.speed_mph).to eq 6.71
        expect(subject.wind.speed_mps).to eq 3
      end
    end
    context 'imperial Russian, overridden units', vcr: { cassette_name: 'weather/weather_id_ru_imperial' } do
      subject do
        client.current_weather(id: 524901, units: 'imperial')
      end
      it 'retrieves city names in Russian' do
        expect(subject).to be_a OpenWeather::Models::City::Weather
        expect(subject.id).to eq 524901
        expect(subject.name).to eq 'Москва'
      end
      it 'retrieves imperial units' do
        expect(subject.main.temp).to eq 53.6
        expect(subject.main.temp_c).to eq 12
        expect(subject.main.temp_k).to eq 285.15
        expect(subject.main.temp_f).to eq 53.6
      end
      it 'converts wind speed from meters per second' do
        expect(subject.wind.speed).to eq 6.71
        expect(subject.wind.speed_mph).to eq 6.71
        expect(subject.wind.speed_mps).to eq 3
      end
    end
    context 'metric French, overridden language', vcr: { cassette_name: 'weather/weather_id_fr_metric' } do
      subject do
        client.current_weather(id: 524901, lang: 'fr')
      end
      it 'retrieves city names in French' do
        expect(subject).to be_a OpenWeather::Models::City::Weather
        expect(subject.id).to eq 524901
        expect(subject.name).to eq 'Moscou'
      end
      it 'retrieves imperial units' do
        expect(subject.main.temp).to eq 13.67
        expect(subject.main.temp_c).to eq 13.67
        expect(subject.main.temp_k).to eq 286.82
        expect(subject.main.temp_f).to eq 56.61
      end
      it 'converts wind speed from meters per second' do
        expect(subject.wind.speed).to eq 9
        expect(subject.wind.speed_mph).to eq 20.13
        expect(subject.wind.speed_mps).to eq 9
      end
    end
  end
end
