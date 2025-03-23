# frozen_string_literal: true

module OpenWeather
  module Models
    module Forecast
      module FiveDay
        class Forecast < Model
          property 'dt', transform_with: ->(v) { Time.at(v).utc } # time of data forcasted, UTC
          property 'main' # Main weather data
          property 'weather' # Array of OpenWeather::Models::Weather
          property 'clouds' # Cloudiness data
          property 'wind' # Wind data
          property 'visibility' # Visibility, meter
          property 'pop' # Probability of precipitation
          property 'rain' # Rain data
          property 'snow' # Snow data
          property 'sys' # System data
          property 'dt_txt' # Date and time of calculation, UTC

          def initialize(args = nil, options = {})
            super args, options

            self.main = OpenWeather::Models::Main.new(main, options) if main
            self.weather = weather.map { |w| OpenWeather::Models::Weather.new(w, options) } if weather
            self.clouds = OpenWeather::Models::Clouds.new(clouds, options) if clouds
            self.wind = OpenWeather::Models::Wind.new(wind, options) if wind
            self.rain = OpenWeather::Models::Rain.new(rain, options) if rain
            self.snow = OpenWeather::Models::Snow.new(snow, options) if snow
            self.sys = OpenWeather::Models::Sys.new(sys, options) if sys
          end
        end
      end
    end
  end
end
