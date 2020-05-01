# frozen_string_literal: true

module OpenWeather
  module Models
    class Clouds < Model
      property 'all' # cloudiness, %
      property 'today' # cloudiness today, %
    end
  end
end
