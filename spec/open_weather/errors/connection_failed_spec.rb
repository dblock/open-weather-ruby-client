# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'connection failed' do
  include_context 'API client'

  it 'raises error', vcr: { cassette_name: 'errors/connection_failed' } do
    expect { client.current_weather(city: 'London') }.to raise_error Faraday::ConnectionFailed
  end
end
