# frozen_string_literal: true

module OpenWeather
  module Models
    module OneCall
      class FeelsLike < Model
        property 'morn'
        property 'day'
        property 'eve'
        property 'night'
      end
    end
  end
end
