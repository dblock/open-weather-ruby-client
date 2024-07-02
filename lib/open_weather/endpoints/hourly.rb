# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module Hourly
      def hourly(lat, lon = nil, options = {})
        # default to the pro endpoint if not specified
        endpoint = options.delete(:endpoint) || pro_endpoint
        options = options.merge(endpoint:)

        options = lat.is_a?(Hash) ? options.merge(lat) : options.merge(lat:, lon:)
        OpenWeather::Models::Forecast::Hourly.new(get('2.5/forecast/hourly', options), options)
      end
    end
  end
end
