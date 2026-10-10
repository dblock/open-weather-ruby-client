# frozen_string_literal: true

module OpenWeather
  module Models
    module Statistics
      class Parameter < Model
        property 'min' # minimum value
        property 'max' # maximum value
        property 'median' # median value
        property 'mean' # average value
        property 'p25' # 25th percentile
        property 'p75' # 75th percentile
        property 'st_dev' # standard deviation
        property 'num' # number of measurements used in the calculation
      end
    end
  end
end
