# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OpenWeather::Models::Station do
  describe '#create!' do
    let(:create_attributes) do
      {
        external_id: 'SF_TEST001',
        name: 'San Francisco Test Station',
        latitude: 37.76,
        longitude: -122.43,
        altitude: 150
      }
    end
    let(:client) { instance_double(OpenWeather::Client) }

    before do
      allow(OpenWeather::Client).to receive(:new).and_return(client)
    end

    it 'registers a station via the Client' do
      expect(client)
        .to receive(:register_station)
        .with(create_attributes.transform_keys(&:to_s))

      described_class.new(create_attributes).create!
    end

    it 'sets the internal id' do
      allow(client)
        .to receive(:register_station)
        .and_return('ID' => 'internal_id')
      model = described_class.new(create_attributes)
      model.create!
      expect(model.id).to eq('internal_id')
    end
  end
end
