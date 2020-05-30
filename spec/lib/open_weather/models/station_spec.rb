# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OpenWeather::Models::Station do
  describe '#create!' do
    it 'registers a station via the Client' do
      create_attributes = {
        external_id: 'SF_TEST001',
        name: 'San Francisco Test Station',
        latitude: 37.76,
        longitude: -122.43,
        altitude: 150
      }
      client = instance_double(OpenWeather::Client)
      expect(OpenWeather::Client).to receive(:new).and_return(client)
      expect(client)
        .to receive(:register_station)
        .with(create_attributes.transform_keys(&:to_s))

      described_class.new(create_attributes).create!
    end
  end
end
