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

  describe '#initialize' do
    it 'accepts String keys without copying them' do
      attributes = { 'lat' => 1.5, 'lon' => 2.5 }
      expect(attributes).not_to receive(:transform_keys)
      coord = OpenWeather::Models::Coord.new(attributes)
      expect(coord.lat).to eq 1.5
      expect(coord.lon).to eq 2.5
    end

    it 'accepts Symbol keys' do
      coord = OpenWeather::Models::Coord.new(lat: 1.5, lon: 2.5)
      expect(coord.lat).to eq 1.5
      expect(coord.lon).to eq 2.5
    end
  end
end

RSpec.describe OpenWeather::Models::Weather do
  it 'returns a frozen icon URI shared by weather with the same icon' do
    first = described_class.new('icon' => '10n')
    second = described_class.new('icon' => '10n')
    expect(first.icon_uri).to eq URI.parse('http://openweathermap.org/img/wn/10n@2x.png')
    expect(first.icon_uri).to be_frozen
    expect(first.icon_uri).to be second.icon_uri
  end
end
