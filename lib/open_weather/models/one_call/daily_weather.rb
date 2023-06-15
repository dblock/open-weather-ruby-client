# frozen_string_literal: true

module OpenWeather
  module Models
    module OneCall
      class DailyWeather < Model
        property 'dt', transform_with: ->(v) { Time.at(v).utc } # time of the forecasted data UTC
        property 'sunrise', transform_with: ->(v) { Time.at(v).utc } # sunrise time, UTC
        property 'sunset', transform_with: ->(v) { Time.at(v).utc } # sunset time, UTC
        property 'moonrise', transform_with: ->(v) { Time.at(v).utc } # moonrise time, UTC
        property 'moonset', transform_with: ->(v) { Time.at(v).utc } # moonset time, UTC
        property 'moon_phase' # Moon phase (0-1)
        property 'summary' # human-readable weather conditions
        property 'temp'
        property 'feels_like'
        property 'pressure' # atmospheric pressure on the sea level, hPa
        property 'humidity' # humidity, %
        temperature_property 'dew_point' # atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form
        speed_property 'wind_speed' # wind speed
        speed_property 'wind_gust' # wind gust
        property 'wind_deg' # wind direction, degrees (meteorological)
        property 'clouds' # cloudiness, %
        property 'uvi' # UV index
        property 'pop' # probability of precipitation
        property 'rain' # precipitation volume, mm
        property 'snow' # snow volume, mm
        property 'weather'

        def initialize(args = nil, options = {})
          super args, options

          self.temp = OpenWeather::Models::OneCall::Temp.new(temp, options) if temp
          self.feels_like = OpenWeather::Models::OneCall::FeelsLike.new(feels_like, options) if feels_like
          self.weather = weather.map { |i| OpenWeather::Models::Weather.new(i, options) } if weather
        end
      end
    end
  end
end
