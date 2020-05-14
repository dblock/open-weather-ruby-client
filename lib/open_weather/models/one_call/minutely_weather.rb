# frozen_string_literal: true

module OpenWeather
  module Models
    module OneCall
      class MinutelyWeather < Model
        property 'dt', transform_with: ->(v) { Time.at(v).utc } # time of the forecasted data UTC
        property 'precipitation'
      end
    end
  end
end
