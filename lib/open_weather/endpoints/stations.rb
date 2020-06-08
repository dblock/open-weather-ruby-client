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
        validate_id(id)

        OpenWeather::Models::Station.new(get("stations/#{id}"))
      end

      def update_station(id, options = {})
        validate_id(id)

        OpenWeather::Models::Station.new(put("stations/#{id}", options))
      end

      def delete_station(id)
        validate_id(id)

        delete("stations/#{id}")
        nil
      end

      def create_measurements(measurements, options = {})
        post('measurements', options.merge(body: measurements))
        nil
      end

      def get_measurements(station_id:, type:, limit:, from:, to:)
        get('measurements', { station_id: station_id, type: type, limit: limit, from: from, to: to })
      end

      private

      def validate_id(id)
        raise ArgumentError, 'Invalid ID' unless id&.is_a?(String)
      end
    end
  end
end
