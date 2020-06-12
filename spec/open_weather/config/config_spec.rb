# frozen_string_literal: true

require 'spec_helper'

describe OpenWeather::Config do
  before do
    OpenWeather.config.reset
  end
  describe '#defaults' do
    it 'sets endpoint' do
      expect(OpenWeather.config.endpoint).to eq 'https://api.openweathermap.org/data'
    end
  end
  describe '#configure' do
    before do
      OpenWeather.configure do |config|
        config.endpoint = 'updated'
      end
    end
    it 'sets endpoint' do
      expect(OpenWeather.config.endpoint).to eq 'updated'
    end
  end
end
