# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OpenWeather::Models::Model do
  context 'with properties that conflict with existing methods' do
    it 'reads min and max temperatures' do
      [
        OpenWeather::Models::OneCall::Temp,
        OpenWeather::Models::Forecast::ThirtyDay::Temp,
        OpenWeather::Models::Stations::Temp
      ].each do |model|
        temp = model.new({ 'min' => 280.15, 'max' => 290.15 }, units: :standard)
        expect(temp.min).to eq 280.15
        expect(temp.max).to eq 290.15
        expect(temp.min_c).to eq 7.0
        expect(temp.max_f).to eq 62.6
      end
    end

    it 'reads min and max pressure' do
      pressure = OpenWeather::Models::Stations::Pressure.new('min' => 1000, 'max' => 1020)
      expect(pressure.min).to eq 1000
      expect(pressure.max).to eq 1020
    end

    it 'reads a zip code' do
      expect(OpenWeather::Models::GeoLocationZip.new('zip' => '94040').zip).to eq '94040'
    end
  end
end
