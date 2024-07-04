# frozen_string_literal: true

module OpenWeather
  module Models
    module Mixins
      module Temp
        extend ActiveSupport::Concern

        class_methods do
          def temperature_property(field)
            property field

            define_method "#{field}_k" do
              to_kelvin(send(field))
            end

            define_method "#{field}_c" do
              to_celcius(send(field))
            end

            define_method "#{field}_f" do
              to_farenheit(send(field))
            end
          end
        end

        private

        def to_kelvin(value)
          case units
          when :metric
            (value.to_f + 273.15).round(2)
          when :imperial
            (((value.to_f - 32) * 5 / 9) + 273.15).round(2)
          else
            value
          end
        end

        def to_celcius(value)
          case units
          when :metric
            value
          when :imperial
            ((value.to_f - 32) * 5 / 9).round(2)
          else
            (value.to_f - 273.15).round(2)
          end
        end

        def to_farenheit(value)
          case units
          when :metric
            ((value.to_f * 9 / 5) + 32).round(2)
          when :imperial
            value
          else
            (((value.to_f - 273.15) * 9 / 5) + 32).round(2)
          end
        end
      end
    end
  end
end
