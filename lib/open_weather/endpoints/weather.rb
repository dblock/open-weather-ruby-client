# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module Weather
      def zip(code, country = nil)
        weather(zip: code, country: country)
      end

      def geo(lat, lon)
        weather(lat: lat, lon: lon)
      end

      def city(name, state = nil, country = nil)
        weather(city: name, state: state, country: country)
      end

      def id(id)
        weather(id: id)
      end

      def weather(options = {})
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
    end
  end
end
