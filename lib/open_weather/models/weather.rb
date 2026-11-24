# frozen_string_literal: true

module OpenWeather
  module Models
    class Weather < Model
      # Icon URIs by icon id, shared and frozen since there are only a few icons.
      ICON_URIS = Concurrent::Map.new

      property 'id' # weather condition id
      property 'main' # group of weather parameters (Rain, Snow, Extreme, etc.)
      property 'description' # weather condition within the group, in your language
      property 'icon_uri', from: 'icon', transform_with: lambda { |v|
        ICON_URIS.compute_if_absent(v) { URI.parse("http://openweathermap.org/img/wn/#{v}@2x.png").freeze }
      }
      property 'icon' # weather icon id
    end
  end
end
