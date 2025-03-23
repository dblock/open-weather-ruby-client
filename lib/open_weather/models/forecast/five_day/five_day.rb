# frozen_string_literal: true

module OpenWeather
  module Models
    module Forecast
      module FiveDay
        class FiveDay < Model
          include Enumerable

          property 'cod'
          property 'message'
          property 'cnt'
          property 'list'

          def initialize(args = nil, options = {})
            super args, options

            self.list = list.map { |forecast| Forecast.new(forecast, options) } if list
          end
        end
      end
    end
  end
end
