# frozen_string_literal: true

module OpenWeather
  module Models
    class Sys < Model
      property 'timezone' # shift in seconds from UTC
      property 'type' # internal parameter
      property 'id' # internal parameter
      property 'message' # internal parameter
      property 'country' # country code
      property 'sunrise', transform_with: ->(v) { Time.at(v).utc } # sunrise time, UTC
      property 'sunset', transform_with: ->(v) { Time.at(v).utc } # sunset time, UTC
    end
  end
end
