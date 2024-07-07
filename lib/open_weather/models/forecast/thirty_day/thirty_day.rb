# frozen_string_literal: true

module OpenWeather
  module Models
    module Forecast
      module ThirtyDay
        class ThirtyDay < Model
          include Enumerable

          property 'cod' # Internal parameter
          property 'message' # Internal parameter
          property 'city'
          property 'cnt' # Number of items in list
          property 'list' # List of ??? objects

          def initialize(args = nil, options = {})
            super args, options

            self.list = list.map { |forecast| Forecast.new(forecast, options) } if list
            self.city = OpenWeather::Models::Forecast::City.new(city, options) if city
          end
        end
      end
    end
  end
end
