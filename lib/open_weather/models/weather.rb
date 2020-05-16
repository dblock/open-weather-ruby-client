# frozen_string_literal: true

module OpenWeather
  module Models
    class Weather < Model
      property 'id' # weather condition id
      property 'main' # group of weather parameters (Rain, Snow, Extreme, etc.)
      property 'description' # weather condition within the group, in your language
      property 'icon_uri', from: 'icon', transform_with: ->(v) { URI.parse("http://openweathermap.org/img/wn/#{v}@2x.png") }
      property 'icon' # weather icon id
    end
  end
end
