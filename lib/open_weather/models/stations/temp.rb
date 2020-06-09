# frozen_string_literal: true

module OpenWeather
  module Models
    module Stations
      class Temp < Model
        temperature_property 'min'
        temperature_property 'max'
        temperature_property 'average'
        property 'weight'
      end
    end
  end
end
