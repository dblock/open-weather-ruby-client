# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OpenWeather::Endpoints::Stations do
  include_context 'API client', endpoint: 'https://api.openweathermap.org/data/3.0'

  describe '#register_station' do
    it 'registers a station', vcr: { cassette_name: 'stations/register_success' } do
      data = client.register_station(
        external_id: 'SF_TEST001',
        name: 'San Francisco Test Station',
        latitude: 37.76,
        longitude: -122.43,
        altitude: 150
      )
      expect(data).to be_a(OpenWeather::Models::Station)
      expect(data).to have_attributes(
        id: '5ed21a12cca8ce0001f1aef1',
        external_id: 'SF_TEST001',
        name: 'San Francisco Test Station',
        latitude: 37.76,
        longitude: -122.43,
        altitude: 150
      )
    end
  end

  describe '#list_stations' do
    it 'retrieves all stations', vcr: { cassette_name: 'stations/list_stations_success' } do
      data = client.list_stations
      expect(data).to be_a(Array)
      expect(data.size).to eq(2)
      expect(data.first).to be_a(OpenWeather::Models::Station)
      expect(data.first).to have_attributes(
        id: '5ed21311cca8ce0001f1aef0',
        external_id: 'SF_TEST001',
        name: 'San Francisco Test Station',
        latitude: 37.76,
        longitude: -122.43,
        altitude: 150
      )
    end
  end

  describe '#get_station' do
    it 'retrieves a station', vcr: { cassette_name: 'stations/get_station_success' } do
      data = client.get_station('5ed21311cca8ce0001f1aef0')
      expect(data).to be_a(OpenWeather::Models::Station)
      expect(data).to have_attributes(
        id: '5ed21311cca8ce0001f1aef0',
        external_id: 'SF_TEST001',
        name: 'San Francisco Test Station',
        latitude: 37.76,
        longitude: -122.43,
        altitude: 150
      )
    end

    context 'with invalid id' do
      it 'raises error' do
        expect { client.delete_station(nil) }.to raise_error ArgumentError
      end
    end
  end

  describe '#update_station' do
    it 'updates a station', vcr: { cassette_name: 'stations/update_station_success' } do
      update_attributes = {
        external_id: 'SF_TEST002',
        name: 'San Francisco Test Station 2'
      }
      data = client.update_station('5ed21311cca8ce0001f1aef0', update_attributes)
      expect(data).to be_a(OpenWeather::Models::Station)
      expect(data).to have_attributes(update_attributes)
    end

    context 'with invalid id' do
      it 'raises error' do
        expect { client.update_station(nil, {}) }.to raise_error ArgumentError
      end
    end
  end

  describe '#delete_station' do
    it 'deletes a station', vcr: { cassette_name: 'stations/delete_station_success' } do
      data = client.delete_station('5ed21311cca8ce0001f1aef0')
      expect(data).to be_nil
    end

    context 'with invalid id' do
      it 'raises error' do
        expect { client.delete_station(nil) }.to raise_error ArgumentError
      end
    end
  end

  describe '#create_measurements' do
    it 'creates measurements', vcr: { cassette_name: 'stations/create_measurement_success' } do
      create_params = {
        "station_id": '5ed21a12cca8ce0001f1aef1',
        "dt": 1479817340,
        "temperature": 18.7,
        "wind_speed": 1.2,
        "wind_gust": 3.4,
        "pressure": 1021,
        "humidity": 87,
        "rain_1h": 2,
        "clouds": [
          {
            "condition": 'NSC'
          }
        ]
      }

      expect(client).to receive(:post)
        .with('measurements', body: [create_params])
        .and_call_original

      data = client.create_measurements([create_params])
      expect(data).to be_nil
    end

    context 'when station does not exist' do
      it 'raises error', vcr: { cassette_name: 'stations/create_measurement_failed_with_invalid_station' } do
        create_params = {
          "station_id": 'abcde',
          "dt": 1479817340,
          "temperature": 18.7,
          "wind_speed": 1.2,
          "wind_gust": 3.4,
          "pressure": 1021,
          "humidity": 87,
          "rain_1h": 2,
          "clouds": [
            {
              "condition": 'NSC'
            }
          ]
        }
        expect { client.create_measurements([create_params]) }
          .to raise_error(OpenWeather::Errors::Fault, /Station id is invalid/)
      end
    end
  end

  describe '#get_measurements' do
    it 'gets measurements', vcr: { cassette_name: 'stations/get_measurement_success' } do
      data = client.get_measurements(
        station_id: '5ed21a12cca8ce0001f1aef1',
        type: 'd',
        limit: 100,
        from: 1469817340,
        to: 1591620047
      )
      expect(data.size).to eq(1)
      measurement = data.first
      expect(measurement).to be_a(OpenWeather::Models::Stations::Measurement)
      expect(measurement).to have_attributes(
        station_id: '5ed21a12cca8ce0001f1aef1',
        type: 'd',
        date: 1479859200
      )
      expect(measurement.temp).to be_a(OpenWeather::Models::Stations::Temp)
      expect(measurement.temp).to have_attributes(
        max: 18.7,
        min: 18.7,
        average: 18.7,
        weight: 1
      )
      expect(measurement.humidity).to be_a(OpenWeather::Models::Stations::Humidity)
      expect(measurement.humidity).to have_attributes(
        average: 87,
        weight: 1
      )
      expect(measurement.pressure).to be_a(OpenWeather::Models::Stations::Pressure)
      expect(measurement.pressure).to have_attributes(
        min: 1021,
        max: 1021,
        average: 1021,
        weight: 1
      )
      expect(measurement.precipitation).to be_a(OpenWeather::Models::Stations::Precipitation)
      expect(measurement.precipitation).to have_attributes(rain: 2)
      expect(measurement.wind).to eq({})
    end

    context 'without required params' do
      it 'raises error' do
        expect { client.get_measurements(something: 'something') }.to raise_error(ArgumentError, /station_id, type, limit, from, to/)
      end
    end
  end
end
