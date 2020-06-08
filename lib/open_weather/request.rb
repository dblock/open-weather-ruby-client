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

    #
    # @param [Symbol] method - Faraday HTTP method.
    # @param [String] path - URL to send.
    # @param [Hash] options - :appid, :lang, :units, :endpoint, :body keys will configure the request.
    #   The rest will be converted to query params for GET/DELETE, or jsonified for POST/PUT.
    #
    # @return [Object] - the Faraday::Response#body.
    #
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
          request.params = { appid: options.delete(:appid) }
          if options.key?(:body)
            request.body = options.delete(:body).to_json
          elsif !options.empty? # is a Hash, so `.present?` doesn't capture the same behaviour
            request.body = options.to_json
          end
        end
        request.options.merge!(options.delete(:request)) if options.key?(:request)
      end
      response.body
    end
  end
end
