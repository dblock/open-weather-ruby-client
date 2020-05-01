# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module Box
      def cities_box(*args)
        options = args[-1].is_a?(Hash) ? args.pop : {}
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
    end
  end
end
