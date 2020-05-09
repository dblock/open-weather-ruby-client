# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'on not found' do
  include_context 'API client'

  it 'raises error', vcr: { cassette_name: 'errors/not_found' } do
    expect { client.current_weather(city: 'London') }.to raise_error Faraday::ResourceNotFound
  end
end
