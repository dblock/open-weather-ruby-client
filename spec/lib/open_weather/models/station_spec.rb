# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OpenWeather::Models::Station do
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
    let(:client) do
      instance_double(OpenWeather::Client,
                      register_station: described_class.new(create_attributes))
    end

    before do
      allow(OpenWeather::Client).to receive(:new).and_return(client)
    end

    it 'registers a station via the Client' do
      expect(client)
        .to receive(:register_station)
        .with(create_attributes)

      described_class.register!(create_attributes)
    end

    it 'returns an instance of the Station' do
      model = described_class.register!(create_attributes)
      expect(model).to be_a(described_class)
      expect(model).to have_attributes(create_attributes)
    end
  end
end
