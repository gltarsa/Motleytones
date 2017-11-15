# frozen_string_literal: true

require "capybara/rails"
require "capybara/rspec"
require "capybara/poltergeist"

# Setup capybara webkit as the driver for javascript-enabled tests.
# Capybara.javascript_driver = :webkit

Capybara.default_selector = :css

Capybara.configure do |config|
  config.match = :prefer_exact
  config.ignore_hidden_elements = false
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new app, window_size: [1600, 1200]
end

# for development: when you want to use a browser to experiment with real-time
# interactions, add `, driver: :chrome` to the test parameters
RSpec.configure do |config|
  config.before(:each) do |example|
    Capybara.current_driver = example.metadata[:driver] if example.metadata[:driver]
  end
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :selenium_firefox do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

# NOTE: disable-gpu is a temporary requirement as of Nov-2017, watch the web and remove it when un-needed.
Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Remote::Capabilities.chrome(
    'chromeOptions' => {
      'args' => %w[headless disable-gpu window-size=1920x1080]
    }
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: options)
end

Capybara.configure do |config|
  config.default_driver = :headless_chrome
  config.javascript_driver = :headless_chrome

  config.default_max_wait_time = 5
  # In our setup, browsers were opening the wrong port, force it here
  config.server_port = 54_321
  config.always_include_port = true
end
