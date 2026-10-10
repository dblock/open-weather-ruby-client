# frozen_string_literal: true

module OpenWeather
  module Endpoints
    module Statistics
      def statistics_year(options = {})
        aggregated('year', options)
      end

      def statistics_month(month, options = {})
        options = month.is_a?(Hash) ? options.merge(month) : options.merge(month: month)
        aggregated('month', options)
      end

      def statistics_day(month, day = nil, options = {})
        options = month.is_a?(Hash) ? options.merge(month) : options.merge(month: month, day: day)
        aggregated('day', options)
      end

      private

      def aggregated(period, options)
        # default to the history endpoint if not specified
        endpoint = options.delete(:endpoint) || history_endpoint
        options = options.merge(endpoint: endpoint)

        OpenWeather::Models::Statistics::Aggregations.new(get("2.5/aggregated/#{period}", options), options)
      end
    end
  end
end
