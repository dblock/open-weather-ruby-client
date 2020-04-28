# frozen_string_literal: true

module OpenWeather
  module Models
    class Sys < Model
      property 'type'
      property 'id'
      property 'message'
      property 'country'
      property 'sunrise', transform_with: ->(v) { Time.at(v).utc }
      property 'sunset', transform_with: ->(v) { Time.at(v).utc }
    end
  end
end
