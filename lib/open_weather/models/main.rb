# frozen_string_literal: true

module OpenWeather
  module Models
    class Main < Model
      property 'temp'
      property 'pressure'
      property 'humidity'
      property 'feels_like'
      property 'temp_min'
      property 'temp_max'
    end
  end
end
