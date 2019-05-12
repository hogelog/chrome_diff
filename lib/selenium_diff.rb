require "selenium_diff/version"
require "selenium_diff/cli"
require "selenium_diff/session"

module SeleniumDiff
  class Error < StandardError; end

  def self.run(**args)
    SeleniumDiff::Session.new.run(**args)
  end
end
