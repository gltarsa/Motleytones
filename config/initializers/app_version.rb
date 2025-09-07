# config/initializers/app_version.rb
# Set a constant for the app version based on the CircleCI or Railway environment variable.
# Fallback to a default value if the variable is not set (e.g., in development).
APP_VERSION = ENV['RAILWAY_GIT_COMMIT_SHA'] || ENV['APP_VERSION'] || 'dev'
