# frozen_string_literal: true

module OpenWeather
  module Models
    class Data < Model
      property 'coord', transform_with: ->(v) { OpenWeather::Models::Coord.new(v) }
      property 'weather', transform_with: ->(v) { v.map { |i| OpenWeather::Models::Weather.new(i) } }
      property 'base'
      property 'main', transform_with: ->(v) { OpenWeather::Models::Main.new(v) }
      property 'visibility'
      property 'wind', transform_with: ->(v) { OpenWeather::Models::Wind.new(v) }
      property 'clouds', transform_with: ->(v) { OpenWeather::Models::Clouds.new(v) }
      property 'rain', transform_with: ->(v) { OpenWeather::Models::Rain.new(v) }
      property 'dt', transform_with: ->(v) { Time.at(v).utc }
      property 'sys', transform_with: ->(v) { OpenWeather::Models::Sys.new(v) }
      property 'id'
      property 'timezone'
      property 'name'
      property 'cod'
    end
  end
end
