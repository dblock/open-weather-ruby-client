# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module Stations
      def register_station(options = {})
        OpenWeather::Models::Station.new(post('stations', options))
      end

      def list_stations
        get('stations').map { |data| OpenWeather::Models::Station.new(data) }
      end

      def get_station(id)
        OpenWeather::Models::Station.new(get("stations/#{id}"))
      end

      def update_station(id, options = {})
        OpenWeather::Models::Station.new(put("stations/#{id}", options))
      end
    end
  end
end
