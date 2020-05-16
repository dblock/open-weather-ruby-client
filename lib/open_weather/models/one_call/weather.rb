# frozen_string_literal: true

module OpenWeather
  module Models
    module OneCall
      class Weather < Model
        property 'lat' #  geographical coordinates of the location (latitude)
        property 'lon' # geographical coordinates of the location (longitude)
        property 'timezone' # timezone name for the requested location
        property 'current'
        property 'minutely'
        property 'hourly'
        property 'daily'

        def initialize(args = nil, options = {})
          super args, options

          self.current = OpenWeather::Models::OneCall::CurrentWeather.new(current, options) if current
          self.minutely = minutely.map { |i| OpenWeather::Models::OneCall::MinutelyWeather.new(i, options) } if minutely
          self.hourly = hourly.map { |i| OpenWeather::Models::OneCall::HourlyWeather.new(i, options) } if hourly
          self.daily = daily.map { |i| OpenWeather::Models::OneCall::DailyWeather.new(i, options) } if daily
        end
      end
    end
  end
end
