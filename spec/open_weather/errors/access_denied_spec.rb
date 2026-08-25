# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'on access denied' do
  include_context 'API client'

  it 'raises error', vcr: { cassette_name: 'errors/access_denied' } do
    expect { client.current_weather(city: 'London') }
      .to raise_error(OpenWeather::Errors::Fault,
                      'Invalid API key. Please see http://openweathermap.org/faq#error401 for more info.')
  end

  it 'exposes response headers', vcr: { cassette_name: 'errors/access_denied' } do
    error = nil
    begin
      client.current_weather(city: 'London')
    rescue OpenWeather::Errors::Fault => e
      error = e
    end
    expect(error.headers).to include('Content-Type' => 'application/json; charset=utf-8')
  end
end
