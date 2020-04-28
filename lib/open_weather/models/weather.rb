# frozen_string_literal: true

module OpenWeather
  module Models
    class Weather < Model
      property 'id'
      property 'main'
      property 'description'
      property 'icon'
    end
  end
end
