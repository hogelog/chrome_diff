require "selenium-webdriver"
require "fileutils"
require "tmpdir"

module SeleniumDiff
  class Session
    def initialize
      driver_options = Selenium::WebDriver::Chrome::Options.new(args: [
          "--headless",
          "--disable-gpu",
          "--disable-translate",
          "--window-size=400,4000",
          "--noerrdialogs"
      ])
      @driver = Selenium::WebDriver::Chrome::Driver.new(options: driver_options)
    end

    def run(from_url:, to_url:, output:)
      compare_status = nil
      Dir.mktmpdir do |tmpdir|
        from_file = File.join(tmpdir, "from.png")
        to_file = File.join(tmpdir, "to.png")
        diff_file = File.join(tmpdir, "diff.png")

        @driver.navigate.to(from_url)
        @driver.save_screenshot(from_file)
        @driver.navigate.to(to_url)
        @driver.save_screenshot(to_file)
        compare_status = system("compare", from_file, to_file, diff_file)
        File.rename(diff_file, output)
      end

      compare_status
    end
  end
end
