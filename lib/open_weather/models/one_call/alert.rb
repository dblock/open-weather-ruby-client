# frozen_string_literal: true

module OpenWeather
  module Models
    module OneCall
      class Alert < Model
        property 'sender_name'
        property 'event'
        property 'start', transform_with: ->(v) { Time.at(v).utc } # UTC
        property 'end', transform_with: ->(v) { Time.at(v).utc } # UTC
        property 'description'
      end
    end
  end
end
