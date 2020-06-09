# frozen_string_literal: true

module OpenWeather
  module Models
    module Stations
      class Measurement < Model
        property 'station_id' # The internal ID of the station
        property 'type' # Type of the aggregated data - minute, hour or day. Specifies the letters m, h or d respectively
        property 'date' # Time of measurement

        def initialize(args = nil, options = {})
          super args, options

          # self.temp =
        end
      end
    end
  end
end



    #     "temp": {
    #         "max": 21.7,
    #         "min": 21.7,
    #         "average": 21.7,
    #         "weight": 1
    #     },
    #     "humidity": {
    #         "average": 77,
    #         "weight": 1
    #     },
    #     "wind": {},
    #     "pressure": {
    #         "min": 1031,
    #         "max": 1031,
    #         "average": 1031,
    #         "weight": 1
    #     },
    #     "precipitation": {}
    # }
