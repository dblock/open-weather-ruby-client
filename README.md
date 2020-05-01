OpenWeather Ruby Client
=======================

[![Gem Version](https://badge.fury.io/rb/open-weather-ruby-client.svg)](https://badge.fury.io/rb/open-weather-ruby-client)
[![Build Status](https://travis-ci.org/dblock/open-weather-ruby-client.svg?branch=master)](https://travis-ci.org/dblock/open-weather-ruby-client)

A Ruby client for the [OpenWeather API v3](https://openweathermap.org/api).

Unlike other clients, including [open-weather](https://github.com/coderhs/ruby_open_weather_map), provides a rich first class interface to OpenWeather models, implements more consistent error handling, and is built with thorough test coverage using actual OpenWeather data.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Current Weather](#current-weather)
  - [Current Weather for Several Cities](#current-weather-for-several-cities)
    - [Cities Within a Rectangle Zone](#cities-within-a-rectangle-zone)
    - [Cities Within a Circle](#cities-within-a-circle)
    - [Multiple Cities by Id](#multiple-cities-by-id)
- [Configuration](#configuration)
  - [Units](#units)
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
data = client.current_weather(city: 'London') # => OpenWeather::Models::CityWeather

data.name # => 'London'
data.main.feels_like # => 277.73
data.main.humidity # => 81
data.main.pressure # => 1005
data.main.temp # => 282.57
data.main.temp_max # => 283.15
data.main.temp_min # => 281.48
```

Returns the current weather in metric units and Russian metadata.

```ruby
data = client.current_weather(city: 'Moscow', units: 'metric', lang: 'ru') # => OpenWeather::Models::CityWeather

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

See [OpenWeather::Models::CityWeather](lib/open_weather/models/city_weather.rb) for all available properties.

### Current Weather for Several Cities

Collection APIs return [OpenWeather::Models::List](lib/open_weather/models/list.rb), which includes multiple instances of [OpenWeather::Models::CityWeather](lib/open_weather/models/city_weather.rb).

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
endpoint            | Defaults to `https://api.openweathermap.org/data/2.5/`.
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
data.main.temp # => 12 (degrees Celsius)
```

```ruby
OpenWeather.configure do |config|
  config.units = 'metric'
end

data = client.weather(id: 2643743)
data.name # => 'London'
data.main.temp # => 12 (degrees Celsius)
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

All errors that return HTTP codes 400-600 result in either `Faraday::Error::ResourceNotFound`, `Faraday::Error::ConnectionFailed` or [OpenWeather::Errors::Fault](lib/open_weather/errors/fault.rb) exceptions.

## Resources

* [OpenWeather API Documentation](https://openweathermap.org/api)

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2020, [Daniel Doubrovkine](https://twitter.com/dblockdotorg)

This project is licensed under the [MIT License](LICENSE.md).
