source 'https://rubygems.org'

gem 'ahoy_matey', '~> 2.0'
gem 'bcrypt', '~> 3.1.7'
gem 'coffee-rails'
# gem 'devise'  need 4.6.0 for security issue (3/19/2019)
gem "devise", ">= 4.6.0"
gem 'font-awesome-rails', '~> 4.4'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails', '~> 4.0'
gem 'pg', '~> 0.18.0'
gem 'sassc-rails'
gem 'rails', '~> 6.0'
gem 'rubocop-rails'
#gem 'sdoc', '~> 0.4.0', group: :doc
gem "simple_form", ">= 5.0.0"
gem 'slim-rails'
gem 'sprockets'
gem 'turbolinks', '~> 5.0.0' # Read more: https://github.com/turbolinks/turbolinks
gem 'uglifier', '>= 1.3.0'

# Updates for security issues
#gem "actionview", ">= 5.1.6.2"
#gem "nokogiri", ">= 1.8.5"
#gem "rack", ">= 2.1"
#gem "loofah", ">= 2.2.3"
#gem "rubyzip", ">= 1.2.2"
#gem "json", ">= 2.3.0"

group :development, :test do
  gem 'awesome_print'
  gem 'database_cleaner', '~> 1.4'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'pry-rescue'
  gem 'rspec-rails'
  gem 'spinach-rails', '~> 0.2'
  gem 'spring'
end

group :development do
  gem 'web-console' # console when execption or <%= console %> in views
end

group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'poltergeist'
  gem 'rails-controller-testing'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
end

ruby '2.7.1'
