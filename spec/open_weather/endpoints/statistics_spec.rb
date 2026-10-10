# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OpenWeather::Endpoints::Statistics do
  include_context 'API client'

  describe '#statistics_month' do
    it 'returns monthly aggregated statistics', vcr: { cassette_name: 'statistics/statistics_month_success' } do
      data = client.statistics_month(2, lat: 35, lon: 139)

      expect(data).to be_a(OpenWeather::Models::Statistics::Aggregations)
      expect(data).to have_attributes(cod: 200, city_id: 5400075)

      aggregation = data.result
      expect(aggregation).to be_a(OpenWeather::Models::Statistics::Aggregation)
      expect(aggregation).to have_attributes(month: 2, sunshine_hours: 102.17)

      expect(aggregation.temp).to be_a(OpenWeather::Models::Statistics::Temp)
      expect(aggregation.temp).to have_attributes(record_min: 269.85, record_max: 296.05, mean: 283.69)

      expect(aggregation.pressure).to be_a(OpenWeather::Models::Statistics::Pressure)
      expect(aggregation.pressure).to have_attributes(min: 988, max: 1036, mean: 1019.34)

      expect(aggregation.humidity).to be_a(OpenWeather::Models::Statistics::Humidity)
      expect(aggregation.humidity).to have_attributes(min: 17, max: 100, mean: 77.38)

      expect(aggregation.wind).to be_a(OpenWeather::Models::Statistics::Wind)
      expect(aggregation.wind).to have_attributes(min: 0, max: 17, mean: 2.06)

      expect(aggregation.precipitation).to be_a(OpenWeather::Models::Statistics::Precipitation)
      expect(aggregation.precipitation).to have_attributes(min: 0, max: 3, mean: 0.16)

      expect(aggregation.clouds).to be_a(OpenWeather::Models::Statistics::Clouds)
      expect(aggregation.clouds).to have_attributes(min: 0, max: 90, mean: 37.4)
    end

    it 'accepts a hash of options', vcr: { cassette_name: 'statistics/statistics_month_success' } do
      data = client.statistics_month(month: 2, lat: 35, lon: 139)
      expect(data.result).to have_attributes(month: 2)
    end
  end

  describe '#statistics_day' do
    it 'returns daily aggregated statistics', vcr: { cassette_name: 'statistics/statistics_day_success' } do
      data = client.statistics_day(1, 1, lat: 35, lon: 139)

      expect(data).to be_a(OpenWeather::Models::Statistics::Aggregations)
      expect(data).to have_attributes(cod: 200, city_id: 5400075)

      aggregation = data.result
      expect(aggregation).to be_a(OpenWeather::Models::Statistics::Aggregation)
      expect(aggregation).to have_attributes(month: 1, day: 1)
      expect(aggregation.temp).to have_attributes(record_min: 275.9, record_max: 291.14)
    end

    it 'accepts a hash of options', vcr: { cassette_name: 'statistics/statistics_day_success' } do
      data = client.statistics_day(month: 1, day: 1, lat: 35, lon: 139)
      expect(data.result).to have_attributes(month: 1, day: 1)
    end
  end

  describe '#statistics_year' do
    it 'returns yearly aggregated statistics', vcr: { cassette_name: 'statistics/statistics_year_success' } do
      data = client.statistics_year(lat: 35, lon: 139)

      expect(data).to be_a(OpenWeather::Models::Statistics::Aggregations)
      expect(data).to have_attributes(cod: 200, city_id: 5400075)
      expect(data.result).to be_a(Array)
      expect(data.result.size).to eq(2)

      data.result.first.tap do |aggregation|
        expect(aggregation).to be_a(OpenWeather::Models::Statistics::Aggregation)
        expect(aggregation).to have_attributes(month: 1, day: 1)
        expect(aggregation.temp).to have_attributes(record_min: 274.44, record_max: 290.45)
      end

      expect(data.map(&:day)).to eq([1, 2])
    end
  end
end
