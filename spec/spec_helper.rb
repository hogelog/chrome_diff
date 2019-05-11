require "bundler/setup"
require "selenium_diff"

module Helpers
  def root_path
    File.dirname(File.dirname(__FILE__))
  end

  def tmp_path
    File.join(root_path, "tmp")
  end
end

RSpec.configure do |config|
  config.include Helpers

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
