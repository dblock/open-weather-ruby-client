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

        def initialize(args = nil, options = {})
          super args, options

          self.temp = OpenWeather::Models::Stations::Temp.new(temp, options) if temp
          self.humidity = OpenWeather::Models::Stations::Humidity.new(humidity, options) if humidity
        end
      end
    end
  end
end

    #     "wind": {},
    #     "pressure": {
    #         "min": 1031,
    #         "max": 1031,
    #         "average": 1031,
    #         "weight": 1
    #     },
    #     "precipitation": {}
    # }
