# frozen_string_literal: true

module OpenWeather
  module Models
    module OneCall
      class Temp < Model
        property 'morn'
        property 'day'
        property 'eve'
        property 'night'
        property 'min'
        property 'max'
      end
    end
  end
end
