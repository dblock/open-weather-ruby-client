# frozen_string_literal: true

module OpenWeather
  module Models
    class Station < Model
      # internal identifier for the station
      property 'id', from: 'ID'
      property 'external_id' # external identifier for the station
      property 'name' # name of the station
      property 'latitude' #  geographical coordinates of the location (latitude)
      property 'longitude' # geographical coordinates of the location (longitude)
      property 'altitude' # height of station above sea level
      property 'created_at' # timestamp when station was created
      property 'updated_at' # timestamp when station was updated
      property 'rank' # rank of station
    end
  end
end
