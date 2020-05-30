# frozen_string_literal: true

module OpenWeather
  module Models
    class Model < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      include OpenWeather::Models::Mixins::Temp
      include OpenWeather::Models::Mixins::Speed

      attr_reader :options

      def initialize(args = nil, options = {})
        transformed_args = args.respond_to?(:transform_keys) ? args.transform_keys(&:to_s) : args
        super transformed_args
        @options = { units: OpenWeather.config.units }.merge(options || {})
      end

      def units
        options && options[:units]&.to_sym
      end
    end
  end
end
