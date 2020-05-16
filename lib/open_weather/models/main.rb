# frozen_string_literal: true

module OpenWeather
  module Models
    class Main < Model
      temperature_property 'temp' # temperature in requested unit
      property 'pressure' # atmospheric pressure on the sea_level or grnd_level when unavailable, hPa
      property 'humidity' # humidity in %
      temperature_property 'feels_like' # temperature, accounting for the human perception of weather, in requested unit
      temperature_property 'temp_min' # minimal currently observed temperature
      temperature_property 'temp_max' # maximal currently observed temperature
      property 'sea_level' # atmospheric pressure on the sea level, hPa
      property 'grnd_level' # atmospheric pressure on the ground level, hPa
    end
  end
end
