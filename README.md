OpenWeather Ruby Client
=======================

[![Gem Version](https://badge.fury.io/rb/open-weather-ruby-client.svg)](https://badge.fury.io/rb/open-weather-ruby-client)
[![Build Status](https://travis-ci.org/dblock/open-weather-ruby-client.svg?branch=master)](https://travis-ci.org/dblock/open-weather-ruby-client)

A complete Ruby client for the [OpenWeather API v3](https://openweathermap.org/api).

Unlike other clients, including [open-weather](https://github.com/coderhs/ruby_open_weather_map), provides a rich first class interface to OpenWeather models, implements more consistent error handling, and is built with thorough test coverage using actual OpenWeather data.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Current Weather](#current-weather)
- [Configuration](#configuration)
- [Errors](#errors)
- [Users](#users)
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

Returns the current weather.

```ruby
data = client.weather(city: 'London') # => OpenWeather::Models::Data

data.name # => 'London'
data.main.feels_like # => 277.73
data.main.humidity # => 81
data.main.pressure # => 1005
data.main.temp # => 282.57
data.main.temp_max # => 283.15
data.main.temp_min # => 281.48
```

You can retrieve data by city, state and country code.

```ruby
client.weather(city: 'New York', state: 'NY', country: 'USA')
```

See [OpenWeather::Models::Data](lib/open_weather/models/data.rb) for all available properties.

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
endpoint            | Defaults to `https://api.openweathermap.org/data/2.5/`.
user_agent          | User-agent, defaults to _OpenWeather Ruby Client/version_.
proxy               | Optional HTTP proxy.
ca_path             | Optional SSL certificates path.
ca_file             | Optional SSL certificates file.
logger              | Optional `Logger` instance that logs HTTP requests.
timeout             | Optional open/read timeout in seconds.
open_timeout        | Optional connection open timeout in seconds.

## Errors

All errors that return HTTP codes 400-600 result in either `Faraday::Error::ResourceNotFound`, `Faraday::Error::ConnectionFailed` or [OpenWeather::Errors::Fault](lib/open_weather/errors/fault.rb) exceptions.

## Resources

* [OpenWeather API Documentation](https://openweathermap.org/api)

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2020, [Daniel Doubrovkine](https://twitter.com/dblockdotorg)

This project is licensed under the [MIT License](LICENSE.md).
