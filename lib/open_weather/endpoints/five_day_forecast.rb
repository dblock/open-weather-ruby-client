# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module FiveDayForecast
      def five_day_forecast(lat, lon = nil, options = {})
        options = lat.is_a?(Hash) ? options.merge(lat) : options.merge(lat: lat, lon: lon)
        OpenWeather::Models::Forecast::FiveDay::FiveDay.new(get('2.5/forecast', options), options)
      end
    end
  end
end
