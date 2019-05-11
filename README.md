# SeleniumDiff

Visual diff tool powered by selenium and headless chrome.

## Installation

```console
$ gem install selenium_diff
```

## Requirements
- Google Chrome (or Chromium)
- ChromeDriver
- ImageMagick

## Usage

```console
$ selenium_diff -f "https://google.com/?q=hello" -t "https://google.com/?q=world"
Visual diff generated: diff.png
There are some differences: https://google.com/?q=hello -> https://google.com/?q=world
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hogelog/selenium_diff.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
