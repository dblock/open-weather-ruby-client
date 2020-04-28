# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module Weather
      #
      # Get current weather.
      #
      def weather(options = {})
        options = options.dup
        unless options.key?(:q)
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
