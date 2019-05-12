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
          "--window-size=800,600",
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

        width, height = screenshot(from_url, from_file)
        screenshot(to_url, to_file, width: width, height: height)

        compare_status = system("compare", from_file, to_file, diff_file)
        File.rename(diff_file, output)
      end

      compare_status
    end

    def screenshot(url, file, width: nil, height: nil)
        @driver.navigate.to(url)
        width ||= @driver.execute_script('return document.documentElement.scrollWidth')
        height ||= @driver.execute_script('return document.documentElement.scrollHeight')
        @driver.manage.window.resize_to(width, height)
        @driver.save_screenshot(file)
        [width, height]
    end
  end
end
