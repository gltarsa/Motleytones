# config/initializers/app_version.rb
# Set a constant for the app version based on an environment variable.
# Fallback to a default value if the variable is not set (e.g., in development).
APP_VERSION = ENV.fetch('APP_VERSION', 'dev').freeze
