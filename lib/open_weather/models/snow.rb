# frozen_string_literal: true

module OpenWeather
  module Models
    class Snow < Model
      property '1h' # snow volume for the last 1 hour, mm
      property '3h' # snow volume for the last 3 hours, mm
    end
  end
end
