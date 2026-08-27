# frozen_string_literal: true

module OpenWeather
  module Models
    module Statistics
      class Temp < Model
        temperature_property 'record_min' # minimum temperature recorded
        temperature_property 'record_max' # maximum temperature recorded
        temperature_property 'average_min' # average of the minimum temperatures
        temperature_property 'average_max' # average of the maximum temperatures
        temperature_property 'median'
        temperature_property 'mean'
        temperature_property 'p25'
        temperature_property 'p75'
        property 'st_dev' # standard deviation
        property 'num' # number of measurements used in the calculation
      end
    end
  end
end
