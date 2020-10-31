# ChromeDiff

Visual diff tool powered by headless chrome.

## Installation

```console
$ gem install chrome_diff
```

## Requirements
- Google Chrome (or Chromium)
- ImageMagick

## Usage

```console
$ chrome-diff -f "https://google.com/?q=hello" -t "https://google.com/?q=world"
There are some diffefences (1.44%): diff.png
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hogelog/chrome_diff.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
