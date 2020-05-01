# frozen_string_literal: true

module OpenWeather
  module Models
    class CityWeather < Model
      property 'coord', transform_with: ->(v) { OpenWeather::Models::Coord.new(v) }
      property 'weather', transform_with: ->(v) { v.map { |i| OpenWeather::Models::Weather.new(i) } }
      property 'base' # internal parameter
      property 'main', transform_with: ->(v) { OpenWeather::Models::Main.new(v) }
      property 'visibility'
      property 'wind', transform_with: ->(v) { OpenWeather::Models::Wind.new(v) }
      property 'clouds', transform_with: ->(v) { OpenWeather::Models::Clouds.new(v) }
      property 'rain', transform_with: ->(v) { OpenWeather::Models::Rain.new(v) }
      property 'snow', transform_with: ->(v) { OpenWeather::Models::Snow.new(v) }
      property 'dt', transform_with: ->(v) { Time.at(v).utc } # time of data calculation, UTC
      property 'sys', transform_with: ->(v) { OpenWeather::Models::Sys.new(v) }
      property 'id' # city id
      property 'timezone' # shift in seconds from UTC
      property 'name' # city name
      property 'cod' # internal parameter
    end
  end
end
