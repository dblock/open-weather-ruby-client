# frozen_string_literal: true

module OpenWeather
  module Models
    class Coord < Model
      property 'lon', from: 'Lon'
      property 'lat', from: 'Lat'
    end
  end
end
