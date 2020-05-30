# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module Stations
      def register_station(options = {})
        OpenWeather::Models::Station.new(
          post('stations', options.merge(use_json: true))
        )
      end
    end
  end
end
