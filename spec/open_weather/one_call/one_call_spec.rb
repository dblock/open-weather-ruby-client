# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'one_call' do
  include_context 'API client'

  it 'lat, lon', vcr: { cassette_name: 'one_call/lat_lon' } do
    data = client.one_call(lat: 33.5312, lon: -111.9426)

    expect(data).to be_a OpenWeather::Models::OneCall::Weather
    expect(data.lat).to eq 33.5312
    expect(data.lon).to eq(-111.9426)
    expect(data.timezone).to eq 'America/Phoenix'
    expect(data.current).to be_a OpenWeather::Models::OneCall::CurrentWeather

    # Minutely
    expect(data.minutely).to be_a Array
    expect(data.minutely.size).to eq 60
    expect(data.minutely.first).to be_a OpenWeather::Models::OneCall::MinutelyWeather
    expect(data.minutely.first.precipitation).to eq 0

    # Hourly
    expect(data.hourly).to be_a Array
    expect(data.hourly.size).to eq 48
    expect(data.hourly.first).to be_a OpenWeather::Models::OneCall::HourlyWeather
    expect(data.hourly.first.temp).to eq 289.2

    # Daily
    expect(data.daily).to be_a Array
    expect(data.daily.size).to eq 8
    expect(data.daily.first).to be_a OpenWeather::Models::OneCall::DailyWeather
    expect(data.daily.first.temp.night).to eq 286.56

    # Alerts
    data.alerts.first.tap do |alert|
      expect(alert).to be_a OpenWeather::Models::OneCall::Alert
      expect(alert.sender_name).to eq 'NWS Phoenix (Central Arizona and California Desert)'
      expect(alert.event).to eq 'Air Quality Alert'
      expect(alert.start).to be_a Time
      expect(alert.end).to be_a Time
      expect(alert.start.to_s).to eq '2023-12-29 17:31:00 UTC'
      expect(alert.end.to_s).to eq '2024-01-02 04:00:00 UTC'
      expect(alert.description).to include '...PM-2.5 HIGH POLLUTION ADVISORY FOR MARICOPA COUNTY'
    end
  end

  it 'lat, lon, excluding minutely and hourly', vcr: { cassette_name: 'one_call/lat_lon_exclude_minutely_hourly' } do
    data = client.one_call(lat: 33.441792, lon: -94.037689, exclude: %w[minutely hourly])
    expect(data).to be_a OpenWeather::Models::OneCall::Weather
    expect(data.lat).to eq 33.44
    expect(data.lon).to eq(-94.04)
    expect(data.timezone).to eq 'America/Chicago'
    expect(data.current).to be_a OpenWeather::Models::OneCall::CurrentWeather
    expect(data.minutely).to be nil
    expect(data.hourly).to be nil
    expect(data.daily).to be_a Array
    expect(data.daily.size).to eq 8
    expect(data.daily.first).to be_a OpenWeather::Models::OneCall::DailyWeather
    expect(data.daily.first.temp.night).to eq 293.4
  end

  it 'lat, lon, yesterday', vcr: { cassette_name: 'one_call/lat_lon_yesterday' } do
    data = client.one_call(lat: 33.441792, lon: -94.037689, dt: Time.at(1589173200))
    expect(data).to be_a OpenWeather::Models::OneCall::Weather
    expect(data.lat).to eq 33.44
    expect(data.lon).to eq(-94.04)
    expect(data.timezone).to eq 'America/Chicago'
    expect(data.current).to be_a OpenWeather::Models::OneCall::CurrentWeather
    expect(data.current.temp).to eq 289.54
    expect(data.hourly).to be_a Array
    expect(data.hourly.size).to eq 24
    expect(data.hourly.first).to be_a OpenWeather::Models::OneCall::HourlyWeather
    expect(data.hourly.first.temp).to eq 295.79
    expect(data.hourly.first.temp_c).to eq 22.64
    expect(data.hourly.first.temp_k).to eq 295.79
    expect(data.hourly.first.temp_f).to eq 72.75
    expect(data.minutely).to be nil
    expect(data.daily).to be nil
  end

  it 'raises an out of range error', vcr: { cassette_name: 'one_call/error_out_of_range' } do
    expect do
      client.one_call(
        lat: 33.441792,
        lon: -94.037689,
        dt: Time.at(1583902800)
      )
    end.to raise_error OpenWeather::Errors::Fault, 'requested time is out of allowed range of 5 days back'
  end
end
