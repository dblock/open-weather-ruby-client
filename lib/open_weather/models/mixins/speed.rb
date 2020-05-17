# frozen_string_literal: true

module OpenWeather
  module Models
    module Mixins
      module Speed
        extend ActiveSupport::Concern

        class_methods do
          def speed_property(field)
            property field

            define_method "#{field}_mps" do
              to_meters_per_sec(send(field))
            end

            define_method "#{field}_mph" do
              to_miles_per_hour(send(field))
            end
          end
        end

        private

        def to_meters_per_sec(value)
          case units
          when :imperial
            (value.to_f / 2.23694).round(2)
          else
            value
          end
        end

        def to_miles_per_hour(value)
          case units
          when :metric
            (value * 2.23694).round(2)
          else
            value
          end
        end
      end
    end
  end
end
