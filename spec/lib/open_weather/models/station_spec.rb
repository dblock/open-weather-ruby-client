# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OpenWeather::Models::Station do
  include_context 'API client', endpoint: 'https://api.openweathermap.org/data/3.0'

  describe '.register!' do
    let(:create_attributes) do
      {
        external_id: 'SF_TEST001',
        name: 'San Francisco Test Station',
        latitude: 37.76,
        longitude: -122.43,
        altitude: 150
      }
    end

    before do
      allow(OpenWeather::Client).to receive(:new).and_return(client)
    end

    it 'registers a station via the Client', vcr: { cassette_name: 'stations/register_success' } do
      model = described_class.register!(create_attributes)
      expect(model).to be_a(described_class)
      expect(model).to have_attributes(create_attributes)
    end
  end
end
