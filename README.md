OpenWeather Ruby Client
=======================

[![Gem Version](https://badge.fury.io/rb/open-weather-ruby-client.svg)](https://badge.fury.io/rb/open-weather-ruby-client)
[![Build Status](https://travis-ci.org/dblock/open-weather-ruby-client.svg?branch=master)](https://travis-ci.org/dblock/open-weather-ruby-client)

A Ruby client for the [OpenWeather API v2.5 and v3.0](https://openweathermap.org/api).

Unlike other clients, including [open-weather](https://github.com/coderhs/ruby_open_weather_map), provides a rich first class interface to OpenWeather models, structured timestamps, built-in metrics conversion for temperature and wind speed, offers more consistent error handling, and is implemented with thorough test coverage using actual OpenWeather data.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Current Weather](#current-weather)
  - [Current Weather for Several Cities](#current-weather-for-several-cities)
    - [Cities Within a Rectangle Zone](#cities-within-a-rectangle-zone)
    - [Cities Within a Circle](#cities-within-a-circle)
    - [Multiple Cities by Id](#multiple-cities-by-id)
  - [One Call](#one-call)
    - [Current and Forecast Weather](#current-and-forecast-weather)
    - [Historical Weather](#historical-weather)
  - [Stations](#stations)
    - [Register a Station](#register-a-station)
    - [List Stations](#list-stations)
    - [Get Station](#get-station)
    - [Update Station](#update-station)
    - [Delete Station](#delete-station)
    - [Create Measurements](#create-measurements)
    - [Get Measurements](#get-measurements)
- [Configuration](#configuration)
  - [Units](#units)
    - [Converting Temperature](#converting-temperature)
    - [Converting Wind Speed](#converting-wind-speed)
  - [Language](#language)
- [Errors](#errors)
- [Resources](#resources)
- [Contributing](#contributing)
- [Copyright and License](#copyright-and-license)

## Installation

Add to Gemfile.

```
gem 'open-weather-ruby-client'
```

Run `bundle install`.

## Usage

Use an access token obtained from [API Keys](https://home.openweathermap.org/api_keys) on the OpenWeather website after registration.

```ruby
client = OpenWeather::Client.new(
  api_key: "1a2b3c4d5a6b7c8d9a8b7c6d5a4b3c2d1"
)
```

### Current Weather

Returns [current weather](https://openweathermap.org/current).

```ruby
data = client.current_weather(city: 'London') # => OpenWeather::Models::City::Weather

data.name # => 'London'
data.dt # => Time
data.main.feels_like # => 277.73
data.main.humidity # => 81
data.main.pressure # => 1005
data.main.temp # => 282.57
data.main.temp_max # => 283.15, degrees Kelvin
data.main.temp_max_c # => 10, degrees Celcius
data.main.temp_max_f # => 50.0, degrees Farenheit
data.main.temp_min # => 281.48
```

Returns the current weather in metric units and Russian metadata.

```ruby
data = client.current_weather(city: 'Moscow', units: 'metric', lang: 'ru') # => OpenWeather::Models::City::Weather

data.name # => 'Москва'
data.main.temp # => 12
```

Returns weather by city, optional state (in the US) and optional ISO 3166 country code.

```ruby
client.current_city('New York', 'NY', 'US')
client.current_weather(city: 'New York', state: 'NY', country: 'US')
```

Returns weather by city ID.

```ruby
client.current_city_id(2643743) # => weather in London
client.current_weather(id: 2643743) # => weather in London
```

Returns weather by latitude and longitude.

```ruby
client.current_geo(51.51, -0.13) # => weather in London
client.current_weather(lat: 51.51, lon: -0.13) # => weather in London
```

Returns weather by zip code with an optional country code (defaults to US).

```ruby
client.current_zip(10018, 'US') # => weather in New York, 10018
client.current_weather(zip: 10018, country: 'US') # => weather in New York, 10018
```

See [OpenWeather::Models::City::Weather](lib/open_weather/models/city/weather.rb) and related [OpenWeather::Models](lib/open_weather/models) for all available properties.

### Current Weather for Several Cities

Collection APIs return [OpenWeather::Models::List](lib/open_weather/models/list.rb), which includes multiple instances of [OpenWeather::Models::City::Weather](lib/open_weather/models/city/weather.rb).

#### Cities Within a Rectangle Zone

```ruby
data = client.current_cities_geo_box(12, 32, 15, 37, 10) # => OpenWeather::Models::List

data.first.name # 'Birkirkara'
data.main.temp # => 16.23
```

You can optionally name parameters.

```ruby
client.current_cities_geo_box(lon_left: 12, lat_bottom: 32, lon_right: 15, lat_top: 37, zoom: 10) # => OpenWeather::Models::List
```

You can use server clustering of points with `cluster: true`.

```ruby
client.current_cities_geo_box(12, 32, 15, 37, 10, cluster: true) # => OpenWeather::Models::List
```

#### Cities Within a Circle

```ruby
data = client.current_cities_geo_circle(55.5, 37.5, 10) # => OpenWeather::Models::List

data.first.name # 'Shcherbinka'
data.main.temp # => 276.86
```

You can optionally name parameters.

```ruby
client.current_cities_geo_circle(lat: 55.5, lon: 37.5, cnt: 7) # => OpenWeather::Models::List
```

#### Multiple Cities by Id

```ruby
data = client.current_cities_id(524901, 703448, 2643743) # => OpenWeather::Models::List

data.first.name # 'Moscow'
data.main.temp # => 285.15
```

### One Call

[One Call API](https://openweathermap.org/api/one-call-api) provides current weather, minute forecast for 1 hour, hourly forecast for 48 hours, daily forecast for 7 days, and historical weather data for 5 previous days for any geographical coordinate.

See [OpenWeather::Models::OneCall](lib/open_weather/models/one_call) for all available models and properties.

#### Current and Forecast Weather

```ruby
data = client.one_call(lat: 33.441792, lon: -94.037689) # => OpenWeather::Models::OneCall::Weather
data.lat # => 33.44
data.lon # => -94.04
data.timezone # => 'America/Chicago'
data.current # => OpenWeather::Models::OneCall::CurrentWeather
data.minutely # => Array[OpenWeather::Models::OneCall::MinutelyWeather]
data.hourly # => Array[OpenWeather::Models::OneCall::HourlyWeather]
data.daily # => Array[OpenWeather::Models::OneCall::DailyWeather]
```

Exclude minutely and hourly data.

```ruby
client.one_call(lat: 33.441792, lon: -94.037689, exclude: ['minutely', 'hourly'])
```

#### Historical Weather

```ruby
data = client.one_call(lat: 33.441792, lon: -94.037689, dt: Time.now - 24 * 60 * 60) # => OpenWeather::Models::OneCall::Weather
data.lat # => 33.44
data.lon # => -94.04
data.timezone # => 'America/Chicago'
data.current # => OpenWeather::Models::OneCall::CurrentWeather
data.hourly # => Array[OpenWeather::Models::OneCall::HourlyWeather]
```

### Stations

The [Stations API](https://openweathermap.org/stations) lets your manage personal weather stations and measurements.

#### Register a Station

To register a station, you can call the client method:
```ruby
data = client.register_station(external_id: 'SF_TEST001', ...) # => OpenWeather::Models::Station
data.id # => '5ed2118acca8ce0001f1aeg1'
data.external_id # => 'SF_TEST001'
```
Alternatively, call `register!` on an instance of `Station`:
```ruby
model = OpenWeather::Models::Station.new(external_id: 'SF_TEST001', ...)
model.register!
model.id # => '5ed2118acca8ce0001f1aeg1'
```

#### List Stations

To list all stations, call the client method:
```ruby
client.list_stations # => Array[OpenWeather::Models::Station]
```

#### Get Station

To get a station, call the client method:
```ruby
client.get_station('5ed2118acca8ce0001f1aeg1') # => OpenWeather::Models::Station
```

#### Update Station

To update a station, call the client method:
```ruby
client.update_station('5ed2118acca8ce0001f1aeg1', external_id: 'SF_TEST002') # => OpenWeather::Models::Station
```
Alternatively, call `update!` on an instance of `Station`:
```ruby
model = OpenWeather::Models::Station.new(external_id: 'SF_TEST001', ...)
model.register!
model.update!(external_id: 'SF_TEST002')
model.external_id # => 'SF_TEST002'
```

#### Delete Station

To delete a station, call the client method:
```ruby
data = client.delete_station('5ed2118acca8ce0001f1aeg1') # => nil
```

#### Create Measurements

To create measurements, call the client method:
```ruby
client.create_measurements([
  {
    "station_id": -1,
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
]) # => nil
```

#### Get Measurements

To get measurements, call the client method with the required parameters:
```ruby
client.get_measurements(
  station_id: '5ed21a12cca8ce0001f1aef1',
  type: 'd',
  limit: 100,
  from: 1469817340,
  to: 1591620047
) # => Array[OpenWeather::Models::Stations::Measurement]
```

## Configuration

You can configure client options, globally.

```ruby
OpenWeather::Client.configure do |config|
  config.api_key = '1a2b3c4d5a6b7c8d9a8b7c6d5a4b3c2d1'
  config.user_agent = 'OpenWeather Ruby Client/1.0'
end
```

The following settings are supported.

setting             | description
--------------------|------------
api_key             | Required API key.
lang                | Default language in API responses.
units               | Default units in API responses.
endpoint            | Defaults to `https://api.openweathermap.org/data`.
user_agent          | User-agent, defaults to _OpenWeather Ruby Client/version_.
proxy               | Optional HTTP proxy.
ca_path             | Optional SSL certificates path.
ca_file             | Optional SSL certificates file.
logger              | Optional `Logger` instance that logs HTTP requests.
timeout             | Optional open/read timeout in seconds.
open_timeout        | Optional connection open timeout in seconds.

### Units

The OpenWeather API returns responses in `standard`, `metric`, and `imperial` units. You can pass `units` into API requests or configure the desired units globally.

```ruby
data = client.weather(id: 2643743, units: 'metric')
data.name # => 'London'
data.main.temp # => 12, degrees Celcius
```

```ruby
OpenWeather.configure do |config|
  config.units = 'metric'
end

data = client.weather(id: 2643743)
data.name # => 'London'
data.main.temp # => 12, degrees Celcius
```

#### Converting Temperature

APIs that return temperature support conversion between default, metric and imperial units, regardless of what units were requested. The following example requests current weather in metric units in Moscow. Use `_k` for Kelvin, `_c` for Celcius and `_f` for Farenheit.

```ruby
data = client.current_weather(city: 'Moscow', units: 'metric') # => OpenWeather::Models::City::Weather

data.main.temp_max # => 12, degrees Celcius, metric as requested
data.main.temp_max_c # => 12, degrees Celcius
data.main.temp_max_k # => 285.15, degrees Kelvin
data.main.temp_max_f # => 53.6, degrees Farenheit
```

#### Converting Wind Speed

Use `_mps` for wind speed in meters-per-second, and `_mph` for miles-per-second.

```ruby
data.wind.speed # => 3, in meters per second, metric as requested
data.main.speed_mph # => 6.71, miles per hour
data.main.speed_mps # 3, meters per second
```

### Language

The OpenWeather API returns responses in English and supports many other languages. You can pass `lang` into API requests or configure the desired language globally.

```ruby
data = client.weather(id: 2643743, lang: 'ru')
data.name # => 'Лондон'
```

```ruby
OpenWeather.configure do |config|
  config.lang = 'ru'
end

data = client.weather(id: 2643743)
data.name # => 'Лондон'
```

## Errors

All errors that return HTTP codes 400-600 result in either `Faraday::ResourceNotFound`, `Faraday::ConnectionFailed` or [OpenWeather::Errors::Fault](lib/open_weather/errors/fault.rb) exceptions.

## Resources

* [OpenWeather API Documentation](https://openweathermap.org/api)

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2020, [Daniel Doubrovkine](https://twitter.com/dblockdotorg)

This project is licensed under the [MIT License](LICENSE.md).
