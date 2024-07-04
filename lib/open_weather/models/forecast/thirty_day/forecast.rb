# frozen_string_literal: true

module OpenWeather
  module Models
    module Forecast
      module ThirtyDay
        class Forecast < Model
          property 'dt', transform_with: ->(v) { Time.at(v).utc } # time of data forcasted, UTC
          property 'sunrise', transform_with: ->(v) { Time.at(v).utc } # Sunrise time, UTC
          property 'sunset', transform_with: ->(v) { Time.at(v).utc } # Sunset time, UTC
          property 'temp' # Array of OpenWeather::Models::Forecast::ThityDay::Temp
          property 'feels_like' # OpenWeather::Models::OneCall::FeelsLike
          property 'pressure' # Atmospheric pressure on the sea level, hPa
          property 'humidity' # Humidity, % (e.g. integer 24 means 24% cloudiness)
          property 'weather' # Array of OpenWeather::Models::Weather
          property 'speed' # Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour
          property 'deg' # Wind direction, degrees (meteorological)
          property 'clouds' # Cloudiness, % (e.g. integer 78 means 78% cloudiness)
          property 'rain' # Precipitation volume, mm. Please note that only mm as units of measurement are available for this parameter
          property 'snow' # Snow volume, mm. Please note that only mm as units of measurement are available for this parameter

          def initialize(args = nil, options = {})
            super args, options

            self.temp = Temp.new(temp, options) if temp
            self.feels_like = OpenWeather::Models::OneCall::FeelsLike.new(feels_like, options) if feels_like
            self.weather = weather.map { |w| OpenWeather::Models::Weather.new(w, options) } if weather
          end
        end
      end
    end
  end
end
