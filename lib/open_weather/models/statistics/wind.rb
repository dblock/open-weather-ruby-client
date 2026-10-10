# frozen_string_literal: true

module OpenWeather
  module Models
    module Statistics
      class Wind < Model
        speed_property 'min'
        speed_property 'max'
        speed_property 'median'
        speed_property 'mean'
        speed_property 'p25'
        speed_property 'p75'
        property 'st_dev' # standard deviation
        property 'num' # number of measurements used in the calculation
      end
    end
  end
end
