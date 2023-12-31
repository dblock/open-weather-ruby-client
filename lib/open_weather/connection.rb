# frozen_string_literal: true

module OpenWeather
  module Connection
    private

    def headers
      {}
    end

    def connection
      @connection ||= begin
        options = {
          headers: headers.merge(
            'Accept' => 'application/json; charset=utf-8',
            'Content-Type' => 'application/json'
          )
        }

        options[:headers]['User-Agent'] = user_agent if user_agent
        options[:proxy] = proxy if proxy
        options[:ssl] = { ca_path: ca_path, ca_file: ca_file } if ca_path || ca_file

        request_options = {}
        request_options[:timeout] = timeout if timeout
        request_options[:open_timeout] = open_timeout if open_timeout
        options[:request] = request_options if request_options.any?

        Faraday.new(endpoint, options) do |f|
          f.request :multipart
          f.request :url_encoded
          f.use ::OpenWeather::Response::RaiseError
          f.response :json, content_type: /\bjson$/
          f.response :logger, logger if logger
        end
      end
    end
  end
end
