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
      options = options.merge(appid: api_key)
      root = options.delete(:endpoint) || endpoint
      path = [root, path].join('/')
      response = connection.send(method) do |request|
        case method
        when :get, :delete
          request.url(path, options)
        when :post, :put
          request.path = path
          request.body = options unless options.empty?
        end
        request.options.merge!(options.delete(:request)) if options.key?(:request)
      end
      response.body
    end
  end
end
