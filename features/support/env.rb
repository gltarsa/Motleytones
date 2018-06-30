# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'
require 'spinach-rails'
require 'rspec/expectations'
require 'capybara/poltergeist'
require 'database_cleaner'
require_relative '../../config/environment'

Capybara.server = :webrick
Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

DatabaseCleaner.strategy = :truncation

Spinach.hooks.after_scenario       { DatabaseCleaner.clean }
Spinach.hooks.on_tag('chrome')     { ::Capybara.current_driver = :selenium_chrome }
Spinach.hooks.on_tag('javascript') { ::Capybara.current_driver = ::Capybara.javascript_driver }
