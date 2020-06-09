# frozen_string_literal: true

module OpenWeather
  module Models
    module Stations
      class Measurement < Model
        property 'station_id' # The internal ID of the station
        property 'type' # Type of the aggregated data - minute, hour or day. Specifies the letters m, h or d respectively
        property 'date' # Time of measurement
        property 'temp'
        property 'humidity'
        property 'wind'
        property 'precipitation'
        property 'pressure'

        def initialize(args = nil, options = {})
          super args, options

          self.temp = OpenWeather::Models::Stations::Temp.new(temp, options) if temp
          self.humidity = OpenWeather::Models::Stations::Humidity.new(humidity, options) if humidity
          self.pressure = OpenWeather::Models::Stations::Pressure.new(pressure, options) if pressure
        end
      end
    end
  end
end
