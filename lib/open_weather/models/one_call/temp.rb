# frozen_string_literal: true

module OpenWeather
  module Models
    module OneCall
      class Temp < Model
        temperature_property 'morn'
        temperature_property 'day'
        temperature_property 'eve'
        temperature_property 'night'
        temperature_property 'min'
        temperature_property 'max'
      end
    end
  end
end
