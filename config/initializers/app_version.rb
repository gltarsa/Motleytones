# config/initializers/app_version.rb
# Set the app version based on the first 7 characters of CircleCI or Railway environment variables.
# Fallback to a default value if the variable is not set (e.g., in development).
abbrev_len = 7
sha = ENV['RAILWAY_GIT_COMMIT_SHA'] || ENV['APP_VERSION'] || 'dev'
APP_VERSION = if sha.length > abbrev_len
                sha[0..(abbrev_len - 1)]
              else
                sha
              end

puts "---------------------------------- env '#{ENV['RAILWAY_GIT_COMMIT_SHA']}'"
puts "---------------------------------- env '#{ENV['APP_VERSION']}'"
puts "---------------------------------- lcl '#{sha}'"
puts "---------------------------------- gbl '#{APP_VERSION}'"
