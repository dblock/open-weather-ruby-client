# frozen_string_literal: true

module OpenWeather
  module Models
    module Forecast
      class Forecast < Model
        property 'dt', transform_with: ->(v) { Time.at(v).utc } # time of data forcasted, UTC
        property 'dt_txt' # Time of data forecasted, ISO, UTC
        property 'main'
        property 'weather'
        property 'clouds'
        property 'wind'
        property 'rain'
        property 'snow'
        property 'visibility' # Average visibility, metres. The maximum value of the visibility is 10km
        property 'pop' # Probability of precipitation. Varies from 0 and 1, where 0 is equal to 0%, 1 is equal to 100%
        property 'sys'

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
