# frozen_string_literal: true

module OpenWeather
  module Models
    module OneCall
      class CurrentWeather < Model
        property 'dt', transform_with: ->(v) { Time.at(v).utc } # time of the forecasted data UTC
        property 'sunrise', transform_with: ->(v) { Time.at(v).utc } # sunrise time, UTC
        property 'sunset', transform_with: ->(v) { Time.at(v).utc } # sunset time, UTC
        temperature_property 'temp' # temperature
        temperature_property 'feels_like' # temperature, accounts for the human perception of weather
        property 'pressure' # atmospheric pressure on the sea level, hPa
        property 'humidity' # humidity, %
        temperature_property 'dew_point' # atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form
        property 'clouds' # cloudiness, %
        property 'uvi' # UV index
        property 'visibility' # average visibility, meters
        property 'wind_speed' # wind speed
        property 'wind_gust' # wind gust
        property 'wind_deg' # wind direction, degrees (meteorological)
        property 'rain'
        property 'snow'
        property 'weather'

        def initialize(args = nil, options = {})
          super args, options

          self.rain = OpenWeather::Models::Rain.new(rain, options) if rain
          self.snow = OpenWeather::Models::Snow.new(snow, options) if snow
          self.weather = weather.map { |i| OpenWeather::Models::Weather.new(i, options) } if weather
        end
      end
    end
  end
end
