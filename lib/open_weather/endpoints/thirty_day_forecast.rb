# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module ThirtyDayForecast
      def thirty_day_forecast(lat, lon = nil, options = {})
        # default to the pro endpoint if not specified
        endpoint = options.delete(:endpoint) || pro_endpoint
        options = options.merge(endpoint: endpoint)

        options = lat.is_a?(Hash) ? options.merge(lat) : options.merge(lat: lat, lon: lon)
        OpenWeather::Models::Forecast::ThirtyDay::ThirtyDay.new(get('2.5/forecast/climate', options), options)
      end
    end
  end
end
