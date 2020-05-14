# frozen_string_literal: true

module OpenWeather
  module Models
    module OneCall
      class HourlyWeather < Model
        property 'dt', transform_with: ->(v) { Time.at(v).utc } # Time of the forecasted data UTC
        property 'temp'
        property 'feels_like'
        property 'pressure' # atmospheric pressure on the sea level, hPa
        property 'humidity' # humidity, %
        property 'dew_point' # atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form
        property 'clouds' # cloudiness, %
        property 'visibility' # average visibility, meters
        property 'wind_speed' # wind speed.
        property 'wind_gust' # wind gust.
        property 'wind_deg' # wind direction, degrees (meteorological)
        property 'rain', transform_with: ->(v) { OpenWeather::Models::Rain.new(v) }
        property 'snow', transform_with: ->(v) { OpenWeather::Models::Snow.new(v) }
        property 'weather', transform_with: ->(v) { v.map { |i| OpenWeather::Models::Weather.new(i) } }
      end
    end
  end
end
