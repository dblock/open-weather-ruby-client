# frozen_string_literal: true

module OpenWeather
  module Models
    class Model < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      include OpenWeather::Models::Mixins::Temp
      include OpenWeather::Models::Mixins::Speed

      attr_reader :options

      # Hashie >= 6 does not define property readers that conflict with existing methods,
      # such as `min`, `max` and `zip`.
      if Gem::Version.new(Hashie::VERSION) >= Gem::Version.new('6.0')
        def self.property(property_name, options = {})
          conflict = method_defined?(property_name) || private_method_defined?(property_name)
          super
          define_method(property_name) { self[property_name] } if conflict
        end
      end

      # Parsed JSON already has String keys, so only copy a Hash that does not.
      def self.string_keys(args)
        return args unless args.respond_to?(:transform_keys) && !args.each_key.all?(String)

        args.transform_keys(&:to_s)
      end

      def initialize(args = nil, options = {})
        super(self.class.string_keys(args))
        @options = { units: OpenWeather.config.units }.merge(options || {})
      end

      def units
        options && options[:units]&.to_sym
      end
    end
  end
end
