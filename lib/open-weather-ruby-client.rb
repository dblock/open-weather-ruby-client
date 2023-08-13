# frozen_string_literal: true

require 'faraday'
require 'faraday/multipart'

require 'json'
require 'logger'
require 'hashie'
require 'time'

require 'active_support/core_ext/object/to_query'
require 'active_support/core_ext/hash'
require 'active_support/concern'

require_relative 'open_weather/version'
require_relative 'open_weather/logger'

require_relative 'open_weather/errors/fault'

require_relative 'open_weather/models'
require_relative 'open_weather/raise_error'
require_relative 'open_weather/connection'
require_relative 'open_weather/request'
require_relative 'open_weather/config'
require_relative 'open_weather/errors'
require_relative 'open_weather/endpoints'
require_relative 'open_weather/client'
