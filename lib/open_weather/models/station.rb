# frozen_string_literal: true

module OpenWeather
  module Models
    class Station < Model
      property 'id', from: 'ID' # internal identifier for the station
      property 'external_id' # external identifier for the station
      property 'name' # name of the station
      property 'latitude' #  geographical coordinates of the location (latitude)
      property 'longitude' # geographical coordinates of the location (longitude)
      property 'altitude' # height of station above sea level
      property 'created_at' # timestamp when station was created
      property 'updated_at' # timestamp when station was updated
      property 'rank' # rank of station

      def register!
        data = OpenWeather::Client.new.register_station(to_h)
        update_attributes!(data)

        self
      end
    end
  end
end
