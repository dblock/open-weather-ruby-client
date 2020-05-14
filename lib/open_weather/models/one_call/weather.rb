# frozen_string_literal: true

module OpenWeather
  module Models
    module OneCall
      class Weather < Model
        property 'lat' #  geographical coordinates of the location (latitude)
        property 'lon' # geographical coordinates of the location (longitude)
        property 'timezone' # timezone name for the requested location
        property 'current', transform_with: ->(v) { OpenWeather::Models::OneCall::CurrentWeather.new(v) }
        property 'minutely', transform_with: ->(v) { v.map { |i| OpenWeather::Models::OneCall::MinutelyWeather.new(i) } }
        property 'hourly', transform_with: ->(v) { v.map { |i| OpenWeather::Models::OneCall::HourlyWeather.new(i) } }
        property 'daily', transform_with: ->(v) { v.map { |i| OpenWeather::Models::OneCall::DailyWeather.new(i) } }
      end
    end
  end
end
