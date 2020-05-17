# frozen_string_literal: true

module OpenWeather
  module Models
    class Wind < Model
      speed_property 'speed' # wind speed in meter/sec or miles/hour
      property 'deg' # wind direction in degrees (meteorological)
    end
  end
end
