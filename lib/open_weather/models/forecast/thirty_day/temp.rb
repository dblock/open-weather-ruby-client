# frozen_string_literal: true

module OpenWeather
  module Models
    module Forecast
      module ThirtyDay
        class Temp < Model
          temperature_property 'day' # Day temperature. Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
          temperature_property 'min' # Min daily temperature. Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
          temperature_property 'max' # Max daily temperature. Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
          temperature_property 'night' # Night temperature. Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
          temperature_property 'eve' # Evening temperature. Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
          temperature_property 'morn' # Morning temperature. Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
        end
      end
    end
  end
end
