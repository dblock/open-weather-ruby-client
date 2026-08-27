# frozen_string_literal: true

module OpenWeather
  module Models
    module Statistics
      class Aggregation < Model
        property 'month' # month of the aggregated data, if applicable
        property 'day' # day of the aggregated data, if applicable
        property 'temp'
        property 'pressure'
        property 'humidity'
        property 'wind'
        property 'precipitation'
        property 'clouds'
        property 'sunshine_hours' # average number of sunshine hours, only present for monthly aggregation

        def initialize(args = nil, options = {})
          super args, options

          self.temp = OpenWeather::Models::Statistics::Temp.new(temp, options) if temp
          self.pressure = OpenWeather::Models::Statistics::Pressure.new(pressure, options) if pressure
          self.humidity = OpenWeather::Models::Statistics::Humidity.new(humidity, options) if humidity
          self.wind = OpenWeather::Models::Statistics::Wind.new(wind, options) if wind
          self.precipitation = OpenWeather::Models::Statistics::Precipitation.new(precipitation, options) if precipitation
          self.clouds = OpenWeather::Models::Statistics::Clouds.new(clouds, options) if clouds
        end
      end
    end
  end
end
