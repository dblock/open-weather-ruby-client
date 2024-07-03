# frozen_string_literal: true

module OpenWeather
  module Config
    extend self

    ATTRIBUTES = %i[
      endpoint
      pro_endpoint
      api_key
      proxy
      user_agent
      ca_path
      ca_file
      logger
      timeout
      open_timeout
      lang
      units
    ].freeze

    attr_accessor(*Config::ATTRIBUTES)

    def reset
      self.endpoint = 'https://api.openweathermap.org/data'
      self.pro_endpoint = 'https://pro.openweathermap.org/data'
      self.api_key = nil
      self.user_agent = "OpenWeather Ruby Client/#{OpenWeather::VERSION}"
      self.ca_path = nil
      self.ca_file = nil
      self.proxy = nil
      self.logger = nil
      self.timeout = nil
      self.open_timeout = nil
      self.lang = nil
      self.units = nil
    end
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

OpenWeather::Config.reset
