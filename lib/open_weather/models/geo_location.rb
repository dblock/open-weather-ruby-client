# frozen_string_literal: true

module OpenWeather
  module Models
    class GeoLocation < Model
      property 'name' # name of the found location
      property 'local_names' # name of the found location in different languages
      property 'lat' # geo location, latitude
      property 'lon' # geo location, longitude
      property 'country' # country of the found location
      property 'state' # state of the found location
    end
  end
end
