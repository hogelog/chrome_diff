require "selenium-webdriver"
require "fileutils"
require "tmpdir"
require "open3"

module SeleniumDiff
  class CompareStatus
    attr_reader :status, :diff, :diff_percent

    def initialize(status, stderr, width, height, fuzz)
      @status = status
      @fuzz = fuzz

      @diff = stderr.to_i
      @diff_percent = @diff.to_f / width / height * 100
    end

    def success?
      @diff_percent <= @fuzz
    end
  end

  class Session
    def initialize(width: SeleniumDiff::DEFAULT_OPTIONS[:width], height: SeleniumDiff::DEFAULT_OPTIONS[:height])
      @width = width
      @height = height
      driver_options = Selenium::WebDriver::Chrome::Options.new(args: [
        "--headless",
        "--disable-gpu",
        "--disable-translate",
        "--window-size=#{width},#{height}",
        "--noerrdialogs",
        "--hide-scrollbars",
        "--hide-scrollbars",
        "device-scale-factor=1",
        "force-device-scale-factor",
      ])
      @driver = Selenium::WebDriver::Chrome::Driver.new(options: driver_options)
    end

    def run(from_url:, to_url:, output:, fuzz: SeleniumDiff::DEFAULT_OPTIONS[:fuzz])
      result = nil
      Dir.mktmpdir do |tmpdir|
        from_file = File.join(tmpdir, "from.png")
        to_file = File.join(tmpdir, "to.png")
        diff_file = File.join(tmpdir, "diff.png")

        screenshot(from_url, from_file)
        screenshot(to_url, to_file)

        _stdout, stderr, status =  Open3.capture3("compare", "-metric", "AE", from_file, to_file, diff_file)
        result = CompareStatus.new(status, stderr, @width, @height, fuzz)

        File.rename(diff_file, output)
      end

      result
    end

    def screenshot(url, file)
        @driver.navigate.to(url)
        wait_complete
        @driver.manage.window.resize_to(@width, @height)
        @driver.save_screenshot(file)
    end

    def wait_complete
      Selenium::WebDriver::Wait.new.until do
        @driver.execute_script('return document.readyState') == "complete"
      end
    end
  end
end
