# frozen_string_literal: true

module OpenWeather
  module Models
    module Forecast
      class City < Model
        property 'id' # City ID
        property 'name' # City name
        property 'coord', transform_with: ->(v) { OpenWeather::Models::Coord.new(v) } # City geo location
        property 'country' # Country code (GB, JP etc.).
        property 'timezone' # shift in seconds from UTC
        property 'sunrise', transform_with: ->(v) { Time.at(v).utc } # Sunrise time, UTC
        property 'sunset', transform_with: ->(v) { Time.at(v).utc } # Sunset time, UTC
      end
    end
  end
end
