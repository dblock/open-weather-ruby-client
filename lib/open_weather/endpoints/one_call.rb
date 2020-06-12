# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module OneCall
      def one_call(lat, lon = nil, options = {})
        options = lat.is_a?(Hash) ? options.merge(lat) : options.merge(lat: lat, lon: lon)
        options[:exclude] = options[:exclude].join(',') if options[:exclude].is_a?(Array)
        options[:dt] = options[:dt].to_i if options[:dt].is_a?(Time)
        path = options.key?(:dt) ? '2.5/onecall/timemachine' : '2.5/onecall'
        OpenWeather::Models::OneCall::Weather.new(get(path, options), options)
      end
    end
  end
end
