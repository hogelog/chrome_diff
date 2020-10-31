require "selenium_diff/version"
require "selenium_diff/cli"
require "selenium_diff/session"

module SeleniumDiff
  class Error < StandardError; end

  DEFAULT_OPTIONS = {
    output: "diff.png",
    width: 800,
    height: 600,
    fuzz: 5,
  }

  def self.run(**args)
    width = args.delete(:width)
    height = args.delete(:height)
    SeleniumDiff::Session.new(width: width, height: height).run(**args)
  end
end
