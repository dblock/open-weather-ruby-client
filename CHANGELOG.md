### 0.6.1 (Next)

* Your contribution here.
* [#46](https://github.com/dblock/open-weather-ruby-client/pull/46): Added support for the five day forecast API - [@mgm702](https://github.com/mgm702).

### 0.6.0 (2024/10/19)

* [#40](https://github.com/dblock/open-weather-ruby-client/pull/40): Fixing rubocop violations and improved .rubocop.yml - [@troya2](https://github.com/troya2).
* [#41](https://github.com/dblock/open-weather-ruby-client/pull/41): Added additional tests for hourly forecast that include all data types - i.e. rain and snow - [@troya2](https://github.com/troya2).
* [#42](https://github.com/dblock/open-weather-ruby-client/pull/42): Added support for the thirty day forecast in the pro 2.5 API - [@troya2](https://github.com/troya2).
* [#45](https://github.com/dblock/open-weather-ruby-client/pull/45): Added support for One Call 3.0 API on base plan - [@dblock](https://github.com/dblock).

### 0.5.0 (2024/07/03)

* [#25](https://github.com/dblock/open-weather-ruby-client/pull/25): Exposed the national weather alerts response in the One Call API - [@troya2](https://github.com/troya2).
* [#38](https://github.com/dblock/open-weather-ruby-client/pull/38): Migrated to One Call 3.0 API - [@jeanmartin](https://github.com/jeanmartin).
* [#39](https://github.com/dblock/open-weather-ruby-client/pull/39): Added support for the hourly forecast in the pro 2.5 API - [@troya2](https://github.com/troya2).

### 0.4.0 (2023/08/13)

* [#33](https://github.com/dblock/open-weather-ruby-client/pull/33): Upgrade Faraday to 2.x - [@dgarwood](https://github.com/dgarwood).

### 0.3.0 (2023/03/25)

* [#30](https://github.com/dblock/open-weather-ruby-client/pull/30): Added support for Ruby 3.2 - [@petergoldstein](https://github.com/petergoldstein).
* [#27](https://github.com/dblock/open-weather-ruby-client/pull/27): Removed default values for Faraday’s SSL settings ca_file and ca_path - [@sunny](https://github.com/sunny).
* [#21](https://github.com/dblock/open-weather-ruby-client/pull/21), [#20](https://github.com/dblock/open-weather-ruby-client/pull/20), [#19](https://github.com/dblock/open-weather-ruby-client/pull/19), [#18](https://github.com/dblock/open-weather-ruby-client/pull/18): Added support for Stations API - [@wasabigeek](https://github.com/wasabigeek).
* [#22](https://github.com/dblock/open-weather-ruby-client/pull/23): Removed API version from `Config#endpoint` - [@dblock](https://github.com/dblock).

### 0.2.0 (2020/05/17)

* [#14](https://github.com/dblock/open-weather-ruby-client/pull/14): Added support for One Call API - [@dblock](https://github.com/dblock).
* [#16](https://github.com/dblock/open-weather-ruby-client/pull/16): Added support for temperature and wind speed conversion - [@dblock](https://github.com/dblock).
* [#16](https://github.com/dblock/open-weather-ruby-client/pull/16): Added `weather#icon_url` returning a parsed `URI` - [@dblock](https://github.com/dblock).
* [#15](https://github.com/dblock/open-weather-ruby-client/pull/15): Renamed `CityWeather` to `OpenWeather::Models::City::Weather` - [@dblock](https://github.com/dblock).
* [#12](https://github.com/dblock/open-weather-ruby-client/pull/12): Cache `Faraday::Connection` for persistent adapters - [@dblock](https://github.com/dblock).
* [#13](https://github.com/dblock/open-weather-ruby-client/pull/13): Require Faraday >= 1.0 - [@dblock](https://github.com/dblock).

### 0.1.0 (2020/05/01)

* Initial public release - [@dblock](https://github.com/dblock).
