# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OpenWeather::Models::Station do
  include_context 'API client'

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
      model = described_class.new(create_attributes)
      result = model.register!
      expect(result.object_id).to eq(model.object_id)
      expect(result).to have_attributes(create_attributes.merge(id: '5ed21a12cca8ce0001f1aef1'))
    end
  end

  describe '.update!' do
    let(:update_attributes) do
      {
        external_id: 'SF_TEST002',
        name: 'San Francisco Test Station 2'
      }
    end

    before do
      allow(OpenWeather::Client).to receive(:new).and_return(client)
    end

    it 'registers a station via the Client', vcr: { cassette_name: 'stations/update_station_success' } do
      model = OpenWeather::Models::Station.new(id: '5ed21311cca8ce0001f1aef0')
      result = model.update!(update_attributes)
      expect(result.object_id).to eq(model.object_id)
      expect(result).to have_attributes(update_attributes)
    end
  end

  describe '.delete!' do
    before do
      allow(OpenWeather::Client).to receive(:new).and_return(client)
    end

    it 'deletes a station via the Client', vcr: { cassette_name: 'stations/delete_station_success' } do
      id = '5ed21311cca8ce0001f1aef0'
      expect(client)
        .to receive(:delete_station)
        .with(id)
        .and_call_original

      model = OpenWeather::Models::Station.new(id:)
      result = model.delete!
      expect(result).to be_nil
    end
  end
end
