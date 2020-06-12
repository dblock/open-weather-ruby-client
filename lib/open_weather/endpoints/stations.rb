# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module Stations
      def register_station(options = {})
        OpenWeather::Models::Station.new(post('3.0/stations', options))
      end

      def list_stations
        get('3.0/stations').map { |data| OpenWeather::Models::Station.new(data) }
      end

      def get_station(id)
        validate_id(id)

        OpenWeather::Models::Station.new(get("3.0/stations/#{id}"))
      end

      def update_station(id, options = {})
        validate_id(id)

        OpenWeather::Models::Station.new(put("3.0/stations/#{id}", options))
      end

      def delete_station(id)
        validate_id(id)

        delete("3.0/stations/#{id}")
        nil
      end

      def create_measurements(measurements, options = {})
        post('3.0/measurements', options.merge(body: measurements))
        nil
      end

      def get_measurements(options)
        required_keys = %i[station_id type limit from to]
        missing_keys = required_keys - options.keys
        raise ArgumentError, "Missing params: #{missing_keys.join(', ')}" if missing_keys.any?

        get('3.0/measurements', options).map { |m| OpenWeather::Models::Stations::Measurement.new(m) }
      end

      private

      def validate_id(id)
        raise ArgumentError, 'Invalid ID' unless id&.is_a?(String)
      end
    end
  end
end
