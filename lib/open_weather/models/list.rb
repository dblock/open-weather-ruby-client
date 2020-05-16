# frozen_string_literal: true

module OpenWeather
  module Models
    class List < Model
      include Enumerable

      property 'cod'
      property 'calctime'
      property 'cnt', from: 'count'
      property 'list'
      property 'message'

      def initialize(args = nil, options = {})
        super args, options

        self.list = list.map { |i| OpenWeather::Models::City::Weather.new(i, options) } if list
      end

      def each(&block)
        list.each(&block)
      end
    end
  end
end
