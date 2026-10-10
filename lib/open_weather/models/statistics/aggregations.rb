# frozen_string_literal: true

module OpenWeather
  module Models
    module Statistics
      class Aggregations < Model
        include Enumerable

        property 'cod'
        property 'city_id'
        property 'calctime'
        property 'result'

        def initialize(args = nil, options = {})
          super args, options

          self.result = if result.is_a?(Array)
                          result.map { |i| OpenWeather::Models::Statistics::Aggregation.new(i, options) }
                        elsif result
                          OpenWeather::Models::Statistics::Aggregation.new(result, options)
                        end
        end

        def each(&block)
          Array(result).each(&block)
        end
      end
    end
  end
end
