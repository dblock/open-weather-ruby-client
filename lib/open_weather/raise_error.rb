# frozen_string_literal: true

module OpenWeather
  module Response
    class RaiseError < ::Faraday::Response::RaiseError
      def on_complete(env)
        case env[:status]
        when 404
          raise Faraday::ResourceNotFound, response_values(env)
        when 407
          # mimic the behavior that we get with proxy requests with HTTPS
          raise Faraday::ConnectionFailed, %(407 "Proxy Authentication Required ")
        when (400...600).freeze
          raise OpenWeather::Errors::Fault, response_values(env)
        end
      end

      def response_values(env)
        {
          status: env.status,
          headers: env.response_headers,
          body: env.body
        }
      end
    end
  end
end
