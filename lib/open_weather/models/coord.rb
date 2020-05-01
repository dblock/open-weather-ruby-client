# frozen_string_literal: true

module OpenWeather
  module Models
    class Coord < Model
      property 'lon', from: 'Lon' # City geo location, longitude
      property 'lat', from: 'Lat' # City geo location, latitude
    end
  end
end
