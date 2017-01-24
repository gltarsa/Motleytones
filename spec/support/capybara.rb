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

Capybara.register_driver :selenium_firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.default_driver = :poltergeist
Capybara.current_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

# In our setup, for some reason the browsers capybara was driving were
# not openning the right host:port. Below, we force the correct host:port.
Capybara.server_port = 7787

# We have more than one controller inheriting from
# ActionController::Base, and, in our app, ApplicationController redefines
# the default_url_options method, so we need to redefine the method for
# the two classes.
# [ApplicationController, ActionController::Base].each do |klass|
#   klass.class_eval do
#     def default_url_options(options = {})
#       { :host => "127.0.0.1", :port => Capybara.server_port }.merge(options)
#     end
#   end
#end
