# Local override
dotenv = File.expand_path("../.env_overrides.rb", __FILE__)
require dotenv if File.exist?(dotenv)

ENV["RAILS_ENV"] ||= "development"

ENV["DATABASE_ADAPTER"] ||= "postgresql"
ENV["DATABASE_NAME"] ||= "motley_#{ENV["RAILS_ENV"]}"
ENV["DATABASE_ENCODING"] ||= "utf8"
ENV["DATABASE_POOL"] ||= "5"
ENV["DATABASE_TIMEOUT"] ||= "5000"

ENV["SECRET_KEY_BASE"]  ||= "define in environment"
ENV["STARTER_PASSWORD"] ||= "secretpw"
