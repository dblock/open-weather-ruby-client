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

      def initialize(args = nil, options = {})
        super args.transform_keys(&:to_s), options
      end

      def create!
        OpenWeather::Client.new.register_station(to_h)
      end
    end
  end
end
