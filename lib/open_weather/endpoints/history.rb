# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module History
      def history_geo(lat, lon = nil, options = {})
        options = lat.is_a?(Hash) ? options.merge(lat) : options.merge(lat: lat, lon: lon)
        history_weather(options)
      end

      def history_city(name, state = nil, country = nil, options = {})
        options = name.is_a?(Hash) ? options.merge(name) : options.merge(city: name, state: state, country: country)
        history_weather(options)
      end

      def history_city_id(id, options = {})
        options = id.is_a?(Hash) ? options.merge(id) : options.merge(id: id)
        history_weather(options)
      end

      def history_weather(options = {})
        if options.key?(:zip) && options.key?(:country)
          options = options.dup
          options[:zip] = [
            options.delete(:zip),
            options.delete(:country)
          ].compact.join(',')
        elsif options.key?(:city)
          options = options.dup
          options[:q] = [
            options.delete(:city),
            options.delete(:state),
            options.delete(:country)
          ].compact.join(',')
        end
        options = options.merge(type: 'hour') unless options.key?(:type)
        OpenWeather::Models::List.new(get('history/city', options))
      end
    end
  end
end
