OpenWeather Ruby Client
=======================

[![Gem Version](https://badge.fury.io/rb/open-weather-ruby-client.svg)](https://badge.fury.io/rb/open-weather-ruby-client)
[![Tests Status](https://github.com/dblock/open-weather-ruby-client/actions/workflows/test.yml/badge.svg)](https://github.com/dblock/open-weather-ruby-client/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/dblock/open-weather-ruby-client/badge.svg?branch=master)](https://coveralls.io/github/dblock/open-weather-ruby-client?branch=master)

A Ruby client for the [OpenWeather API v2.5 and v3.0](https://openweathermap.org/api).

It provides rich OpenWeather models with structured timestamps, temperature and wind speed conversion, and consistent error handling, and is tested with actual OpenWeather data.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Current Weather](#current-weather)
  - [Forecasts](#forecasts)
  - [More](#more)
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

Get an API key from [API Keys](https://home.openweathermap.org/api_keys) on the OpenWeather website after registration.

```ruby
client = OpenWeather::Client.new(api_key: ENV['OPEN_WEATHER_API_KEY'])
```

### Current Weather

```ruby
data = client.current_weather(city: 'London') # => OpenWeather::Models::City::Weather

data.name # => 'London'
data.dt # => Time
data.main.temp # => 282.57, degrees Kelvin by default
data.main.temp_c # => 9.42, degrees Celsius
data.weather.first.description # => 'light rain'
```

Look up weather by city and country (`city: 'London', country: 'UK'`), id (`id: 2643743`), coordinates (`lat: 51.51, lon: -0.13`) or zip code (`zip: 10018, country: 'US'`).

### Forecasts

```ruby
data = client.one_call(lat: 33.5312, lon: -111.9426) # => OpenWeather::Models::OneCall::Weather

data.timezone # => 'America/Phoenix'
data.current # => OpenWeather::Models::OneCall::CurrentWeather
data.hourly.first.temp # => 289.2
data.daily # => Array[OpenWeather::Models::OneCall::DailyWeather]
```

### More

See [docs/USAGE.md](docs/USAGE.md) for all APIs, including weather for several cities, One Call history, hourly, 5 day and 30 day forecasts, stations and geocoding.

## Configuration

You can configure client options, globally.

```ruby
OpenWeather::Client.configure do |config|
  config.api_key = '1a2b3c4d5a6b7c8d9a8b7c6d5a4b3c2d1'
  config.user_agent = 'OpenWeather Ruby Client/1.0'
end
```

The following settings are supported.

| setting      | description                                                |
| ------------ | ---------------------------------------------------------- |
| api_key      | Required API key.                                          |
| lang         | Default language in API responses.                         |
| units        | Default units in API responses.                            |
| endpoint     | Defaults to `https://api.openweathermap.org/data`.         |
| user_agent   | User-agent, defaults to _OpenWeather Ruby Client/version_. |
| proxy        | Optional HTTP proxy.                                       |
| ca_path      | Optional SSL certificates path.                            |
| ca_file      | Optional SSL certificates file.                            |
| logger       | Optional `Logger` instance that logs HTTP requests.        |
| timeout      | Optional open/read timeout in seconds.                     |
| open_timeout | Optional connection open timeout in seconds.               |

### Units

The OpenWeather API returns responses in `standard`, `metric`, and `imperial` units. You can pass `units` into API requests or configure the desired units globally.

```ruby
data = client.current_weather(id: 2643743, units: 'metric')
data.name # => 'London'
data.main.temp # => 12, degrees Celsius
```

```ruby
OpenWeather.configure do |config|
  config.units = 'metric'
end

data = client.current_weather(id: 2643743)
data.name # => 'London'
data.main.temp # => 12, degrees Celsius
```

#### Converting Temperature

APIs that return temperature support conversion between default, metric and imperial units, regardless of what units were requested. The following example requests current weather in metric units in Moscow. Use `_k` for Kelvin, `_c` for Celsius and `_f` for Fahrenheit.

```ruby
data = client.current_weather(city: 'Moscow', units: 'metric') # => OpenWeather::Models::City::Weather

data.main.temp_max # => 12, degrees Celsius, metric as requested
data.main.temp_max_c # => 12, degrees Celsius
data.main.temp_max_k # => 285.15, degrees Kelvin
data.main.temp_max_f # => 53.6, degrees Fahrenheit
```

#### Converting Wind Speed

Use `_mps` for wind speed in meters per second, and `_mph` for miles per hour.

```ruby
data.wind.speed # => 3, in meters per second, metric as requested
data.wind.speed_mph # => 6.71, miles per hour
data.wind.speed_mps # => 3, meters per second
```

### Language

The OpenWeather API returns responses in English and supports many other languages. You can pass `lang` into API requests or configure the desired language globally.

```ruby
data = client.current_weather(id: 2643743, lang: 'ru')
data.name # => 'Лондон'
```

```ruby
OpenWeather.configure do |config|
  config.lang = 'ru'
end

data = client.current_weather(id: 2643743)
data.name # => 'Лондон'
```

## Errors

All errors that return HTTP codes 400-600 result in either `Faraday::ResourceNotFound`, `Faraday::ConnectionFailed` or [OpenWeather::Errors::Fault](lib/open_weather/errors/fault.rb) exceptions.

## Resources

* [OpenWeather API Documentation](https://openweathermap.org/api)

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md), [CHANGELOG](CHANGELOG.md), [UPGRADING](UPGRADING.md) and [RELEASING](RELEASING.md).

## Copyright and License

Copyright (c) 2020, [Daniel Doubrovkine](https://twitter.com/dblockdotorg)

This project is licensed under the [MIT License](LICENSE.md).
