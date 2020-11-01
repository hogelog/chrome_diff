# ChromeDiff
[![Gem Version](https://badge.fury.io/rb/chrome_diff.svg)](https://badge.fury.io/rb/chrome_diff)

Visual diff tool powered by headless chrome.

This tool controls Chrome by [Chrome DevTools Protocol](https://chromedevtools.github.io/devtools-protocol/) based on [Ferrum](https://github.com/rubycdp/ferrum).

## Installation

```console
$ gem install chrome_diff
```

## Requirements
- Google Chrome (or Chromium)
- ImageMagick

## Usage

### Command-line
```console
$ chrome-diff -f "https://google.com/?q=hello" -t "https://google.com/?q=world"
There are some diffefences (1.44%): diff.png
```

#### Options

```console
Usage: chrome-diff [options]
    -f, --from-url [FROM_URL]        From url
    -t, --to-url [TO_URL]            To url
    -o, --output [OUTPUT]            Output file
    -w, --width [WIDTH]              Window width (default 800)
    -h, --height [HEIGHT]            Window height (default 600)
    -q, --quiet                      Quiet mode
        --threshold [THRESHOLD]      Threshold percent (default 1%)
        --debug                      Debug mode (default false)
        --no-output                  Don't output diff file
        --full-screenshot            Capture full screenshot
```

### As library

```ruby
session = ChromeDiff::Session.new
session.compare("https://example.com/", "https://www.google.com/")
```

#### Customize

```ruby
session = ChromeDiff::Session.new(width: 800, height: 600, timeout: 5, debug: false)
session.compare(from_url: from_url, to_url: to_url, output: "diff.png", threshold: 1, full_screenshot: false)
```

- `width`: window width (default 800px)
- `height`: window height (default 600px)
- `timeout`: browser timeout (default 5 seconds)
- `debug`: debug mode (default false)
- `from_url`: from url (required)
- `to_url`: to url (required)
- `output`: output diff image (default diff.png)
- `threshold`: threshold percent (default 1%)
- `full_screenshot`: take full screenshot (default false) 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hogelog/chrome_diff.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
