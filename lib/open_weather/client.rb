# frozen_string_literal: true

module OpenWeather
  class Client
    include Connection
    include Request
    include Endpoints::Current
    include Endpoints::Hourly
    include Endpoints::ThirtyDayForecast
    include Endpoints::FiveDayForecast
    include Endpoints::OneCall
    include Endpoints::Stations

    attr_accessor(*Config::ATTRIBUTES)

    def initialize(options = {})
      OpenWeather::Config::ATTRIBUTES.each do |key|
        send("#{key}=", options[key] || OpenWeather.config.send(key))
      end
      @logger ||= OpenWeather::Logger.logger
    end

    class << self
      def configure
        block_given? ? yield(Config) : Config
      end

      def config
        Config
      end
    end
  end
end
