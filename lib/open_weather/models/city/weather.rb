# frozen_string_literal: true

module OpenWeather
  module Models
    module City
      class Weather < Model
        property 'coord'
        property 'weather'
        property 'base' # internal parameter
        property 'main'
        property 'visibility'
        property 'wind'
        property 'clouds'
        property 'rain'
        property 'snow'
        property 'dt', transform_with: ->(v) { Time.at(v).utc } # time of data calculation, UTC
        property 'sys'
        property 'id' # city id
        property 'timezone' # shift in seconds from UTC
        property 'name' # city name
        property 'cod' # internal parameter

        def initialize(args = nil, options = {})
          super args, options

          self.coord = OpenWeather::Models::Coord.new(coord, options) if coord
          self.weather = weather.map { |i| OpenWeather::Models::Weather.new(i, options) } if weather
          self.main = OpenWeather::Models::Main.new(main, options) if main
          self.wind = OpenWeather::Models::Wind.new(wind, options) if wind
          self.clouds = OpenWeather::Models::Clouds.new(clouds, options) if clouds
          self.rain = OpenWeather::Models::Rain.new(rain, options) if rain
          self.snow = OpenWeather::Models::Snow.new(snow, options) if snow
          self.sys = OpenWeather::Models::Sys.new(sys, options) if sys
        end
      end
    end
  end
end
