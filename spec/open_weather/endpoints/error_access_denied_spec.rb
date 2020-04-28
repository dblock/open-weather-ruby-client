# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'on access denied' do
  include_context 'API client'

  it 'raises error', vcr: { cassette_name: 'errors/access_denied' } do
    expect { client.weather(city: 'London') }.to raise_error(OpenWeather::Errors::Fault, 'Invalid API key. Please see http://openweathermap.org/faq#error401 for more info.')
  end
end
