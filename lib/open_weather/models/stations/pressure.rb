# frozen_string_literal: true

module OpenWeather
  module Models
    module Stations
      class Pressure < Model
        property 'min'
        property 'max'
        property 'average'
        property 'weight'
      end
    end
  end
end
