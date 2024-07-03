# frozen_string_literal: true

module OpenWeather
  module Models
    module Forecast
      class Hourly < Model
        include Enumerable

        property 'cod'
        property 'calctime'
        property 'cnt', from: 'count'
        property 'list'
        property 'message'
        property 'city'

        def initialize(args = nil, options = {})
          super args, options

          self.list = list.map { |forecast| OpenWeather::Models::Forecast::Forecast.new(forecast, options) } if list
          self.city = OpenWeather::Models::Forecast::City.new(city, options) if city
        end
      end
    end
  end
end
