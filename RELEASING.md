# Releasing OpenWeather-Ruby-Client

There're no hard rules about when to release open-weather-ruby-client. Release bug fixes frequently, features not so frequently and breaking API changes rarely.

### Release

Run tests, check that all tests succeed locally.

```
bundle install
rake
```

Check that the last build succeeded in GitHub Actions for all supported platforms.

Change "Next" in [CHANGELOG.md](CHANGELOG.md) to the current date.

```
### 0.2.2 (7/10/2015)
```

Remove the line with "Your contribution here.", since there will be no more contributions to this release.

Commit your changes.

```
git add CHANGELOG.md
git commit -m "Preparing for release, 0.2.2."
git push origin master
```

Release.

```
$ rake release

open-weather-ruby-client 0.2.2 built to pkg/open-weather-ruby-client-0.2.2.gem.
Tagged v0.2.2.
Pushed git commits and tags.
Pushed open-weather-ruby-client 0.2.2 to rubygems.org.
```

### Prepare for the Next Version

Add the next release to [CHANGELOG.md](CHANGELOG.md).

```
### 0.2.3 (Next)

* Your contribution here.
```

Increment the third version number in [lib/open_weather/version.rb](lib/open_weather/version.rb).

Commit your changes.

```
git add CHANGELOG.md lib/open_weather/version.rb
git commit -m "Preparing for next development iteration, 0.2.3."
git push origin master
```
