# frozen_string_literal: true

module OpenWeather
  module Models
    module OneCall
      class FeelsLike < Model
        temperature_property 'morn'
        temperature_property 'day'
        temperature_property 'eve'
        temperature_property 'night'
      end
    end
  end
end
