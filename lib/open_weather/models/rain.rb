# frozen_string_literal: true

module OpenWeather
  module Models
    class Rain < Model
      property '1h' # rain volume for the last 1 hour, mm
      property '3h' # rain volume for the last 3 hours, mm
    end
  end
end
