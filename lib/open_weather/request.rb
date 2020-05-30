# frozen_string_literal: true

module OpenWeather
  module Request
    def get(path, options = {})
      request(:get, path, options)
    end

    def post(path, options = {})
      request(:post, path, options)
    end

    def put(path, options = {})
      request(:put, path, options)
    end

    def delete(path, options = {})
      request(:delete, path, options)
    end

    private

    def request(method, path, options)
      options = options.dup
      options[:appid] ||= api_key if api_key.present?
      options[:lang] ||= lang if lang.present?
      options[:units] ||= units if units.present?
      root = options.delete(:endpoint) || endpoint
      path = [root, path].join('/')
      response = connection.send(method) do |request|
        case method
        when :get, :delete
          request.url(path, options)
        when :post, :put
          request.path = path
          if options.delete(:use_json)
            request.params = { appid: options.delete(:appid) }
            request.headers['Content-Type'] = 'application/json'
            request.body = options.to_json unless options.empty?
          else
            request.body = options unless options.empty?
          end
        end
        request.options.merge!(options.delete(:request)) if options.key?(:request)
      end
      response.body
    end
  end
end
