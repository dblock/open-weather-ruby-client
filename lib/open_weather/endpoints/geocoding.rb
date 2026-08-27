# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module Geocoding
      def geo_direct(name, state = nil, country = nil, options = {})
        options = name.is_a?(Hash) ? options.merge(name) : options.merge(city: name, state: state, country: country)
        options[:q] = [
          options.delete(:city),
          options.delete(:state),
          options.delete(:country)
        ].compact.join(',')
        options[:endpoint] ||= geo_endpoint

        get('1.0/direct', options).map { |data| OpenWeather::Models::GeoLocation.new(data) }
      end

      def geo_reverse(lat, lon = nil, options = {})
        options = lat.is_a?(Hash) ? options.merge(lat) : options.merge(lat: lat, lon: lon)
        options[:endpoint] ||= geo_endpoint

        get('1.0/reverse', options).map { |data| OpenWeather::Models::GeoLocation.new(data) }
      end

      def geo_zip(code, country = nil, options = {})
        options = code.is_a?(Hash) ? options.merge(code) : options.merge(zip: code, country: country)
        options[:zip] = [
          options.delete(:zip),
          options.delete(:country)
        ].compact.join(',')
        options[:endpoint] ||= geo_endpoint

        OpenWeather::Models::GeoLocationZip.new(get('1.0/zip', options))
      end
    end
  end
end
