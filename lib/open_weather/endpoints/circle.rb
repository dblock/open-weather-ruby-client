# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module Box
      def cities_circle(*args)
        options = args[-1].is_a?(Hash) ? args.pop : {}

        if args.any?
          options[:lat] = args.shift
          options[:lon] = args.shift
          options[:cnt] = args.shift || 1
        end

        OpenWeather::Models::List.new(get('find', options))
      end
    end
  end
end
