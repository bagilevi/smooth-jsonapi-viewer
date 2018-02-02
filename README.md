# smooth-jsonapi-viewer

Ruby on Rails application that renders [{json:api}](http://jsonapi.org/) documents in a easy-to-understand format. It includes `included` entities and color-codes entities by type.

![screenshot](doc/screenshot.png "Screenshot")

## Installation

##### Install Ruby
If you're using Homebrew on OS X:

```
brew install ruby
```

Otherwise, refer to the [Ruby Installation Guide](https://www.ruby-lang.org/en/documentation/installation/).

##### Install Bundler:

```
gem install bundler
```

##### Install the app:

```
git clone https://github.com/bagilevi/smooth-jsonapi-viewer
cd smooth-jsonapi-viewer
bundle install
bundle exec rails server -p 4183
```

## Usage

Navigate to http://localhost:4183/example to view the example.

Navigate to http://localhost:4183/ and paste your JSON.
