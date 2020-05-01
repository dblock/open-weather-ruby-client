# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module Current
      def current_zip(code, country = nil, options = {})
        options = code.is_a?(Hash) ? options.merge(code) : options.merge(zip: code, country: country)
        current_weather(options)
      end

      def current_geo(lat, lon = nil, options = {})
        options = lat.is_a?(Hash) ? options.merge(lat) : options.merge(lat: lat, lon: lon)
        current_weather(options)
      end

      def current_city(name, state = nil, country = nil, options = {})
        options = name.is_a?(Hash) ? options.merge(name) : options.merge(city: name, state: state, country: country)
        current_weather(options)
      end

      def current_city_id(id, options = {})
        options = id.is_a?(Hash) ? options.merge(id) : options.merge(id: id)
        current_weather(options)
      end

      def current_weather(options = {})
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
        OpenWeather::Models::Data.new(get('weather', options))
      end

      def current_cities_geo_box(*args)
        options = args[-1].is_a?(Hash) ? args.pop.dup : {}
        options[:bbox] = args.join(',') if args.any?
        options[:bbox] ||= [
          options.delete(:lon_left),
          options.delete(:lat_bottom),
          options.delete(:lon_right),
          options.delete(:lat_top),
          options.delete(:zoom)
        ].join(',')
        OpenWeather::Models::List.new(get('box/city', options))
      end

      def current_cities_geo_circle(*args)
        options = args[-1].is_a?(Hash) ? args.pop.dup : {}

        if args.any?
          options[:lat] = args.shift
          options[:lon] = args.shift
          options[:cnt] = args.shift || 1
        end

        OpenWeather::Models::List.new(get('find', options))
      end

      def current_cities_id(*args)
        options = args[-1].is_a?(Hash) ? args.pop.dup : {}
        options[:id] = args.join(',') if args.any?
        options[:id] = options.delete(:ids) if options.key?(:ids)
        options[:id] = options[:id].join(',') if options[:id].is_a?(Array)
        OpenWeather::Models::List.new(get('group', options))
      end
    end
  end
end
