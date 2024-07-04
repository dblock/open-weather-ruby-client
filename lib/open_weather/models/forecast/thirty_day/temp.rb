# frozen_string_literal: true

module OpenWeather
  module Models
    module Forecast
      module ThirtyDay
        class Temp < Model
          temperature_property 'day' # Day temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
          temperature_property 'min' # Min daily temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
          temperature_property 'max' # Max daily temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
          temperature_property 'night' # Night temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
          temperature_property 'eve' # Evening temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
          temperature_property 'morn' # Morning temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
        end
      end
    end
  end
end
