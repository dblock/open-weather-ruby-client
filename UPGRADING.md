Upgrading OpenWeather Ruby Client
=================================

### Upgrading to >= 0.3.0

[#27](https://github.com/dblock/open-weather-ruby-client/pull/27) Removes default values for Faraday's SSL settings `ca_file` and `ca_path`.

If you previously relied on `OpenSSL::X509::DEFAULT_CERT_FILE` or `OpenSSL::X509::DEFAULT_CERT_DIR` to set these values you must now do so explicitly. E.g.:

```ruby
OpenWeather::Client.configure do |config|
  config.ca_path = OpenSSL::X509::DEFAULT_CERT_DIR
  config.ca_file = OpenSSL::X509::DEFAULT_CERT_FILE
end
```
