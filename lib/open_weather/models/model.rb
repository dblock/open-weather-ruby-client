# frozen_string_literal: true

module OpenWeather
  module Models
    class Model < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      include OpenWeather::Models::Mixins::Temp

      attr_reader :options

      def initialize(args = nil, options = {})
        super args
        @options = { units: OpenWeather.config.units }.merge(options || {})
      end

      def units
        options && options[:units]&.to_sym
      end
    end
  end
end
