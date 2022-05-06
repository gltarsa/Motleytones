# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'
require 'spinach-rails'
require 'database_cleaner'
require 'webdrivers'
require_relative '../../config/environment'
require_relative '../../spec/spec_helper'

JS_DRIVER = :selenium_chrome_headless

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before(:each) do |example|
    Capybara.current_driver = JS_DRIVER if example.metadata[:js]
    Capybara.current_driver = :selenium if example.metadata[:selenium]
    Capybara.current_driver = :selenium_chrome if example.metadata[:selenium_chrome]
  end

  config.after(:each) do
    Capybara.use_default_driver
  end
end

Capybara.default_driver = :rack_test
Capybara.javascript_driver = JS_DRIVER
Capybara.default_max_wait_time = 2

DatabaseCleaner.strategy = :truncation

Spinach.hooks.after_scenario       { DatabaseCleaner.clean }
Spinach.hooks.on_tag('chrome')     { ::Capybara.current_driver = :selenium_chrome }
Spinach.hooks.on_tag('javascript') { ::Capybara.current_driver = ::Capybara.javascript_driver }
