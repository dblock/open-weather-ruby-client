# frozen_string_literal: true

module OpenWeather
  module Models
    class Weather < Model
      property 'id' # weather condition id
      property 'main' # group of weather parameters (Rain, Snow, Extreme, etc.)
      property 'description' # weather condition within the group, in your language
      property 'icon' # weather icon id
    end
  end
end
