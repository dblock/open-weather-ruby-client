# frozen_string_literal: true

module OpenWeather
  module Models
    class List < Model
      include Enumerable

      property 'cod'
      property 'calctime'
      property 'cnt', from: 'count'
      property 'list', transform_with: ->(v) { v.map { |i| OpenWeather::Models::Data.new(i) } }
      property 'message'

      def each(&block)
        list.each(&block)
      end
    end
  end
end
