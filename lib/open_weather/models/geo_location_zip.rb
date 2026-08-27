# frozen_string_literal: true

module OpenWeather
  module Models
    class GeoLocationZip < Model
      property 'zip' # zip/post code
      property 'name' # name of the found location
      property 'lat' # geo location, latitude
      property 'lon' # geo location, longitude
      property 'country' # country of the found location
    end
  end
end
