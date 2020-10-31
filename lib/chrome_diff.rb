require "chrome_diff/version"
require "chrome_diff/cli"
require "chrome_diff/session"

module ChromeDiff
  class Error < StandardError; end

  DEFAULT_OPTIONS = {
    output: "diff.png",
    width: 800,
    height: 600,
    fuzz: 1,
    timeout: 5,
  }

  def self.run(**args)
    width = args.delete(:width)
    height = args.delete(:height)
    timeout = args.delete(:timeout)
    debug = args.delete(:debug)

    begin
      session = ChromeDiff::Session.new(width: width, height: height, timeout: timeout, debug: debug)
      session.compare(**args)
    ensure
      session.browser&.quit
    end
  end
end
