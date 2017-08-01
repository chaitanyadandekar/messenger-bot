source 'https://rubygems.org'
ruby '2.3.3'

gem 'bundler'
gem 'rake'
gem 'hanami',       '~> 0.9'
gem 'hanami-model', '~> 0.7'
gem 'hanami-controller'
gem 'hanami-view'

gem 'pg'
gem 'sidekiq', '~> 4.0.2'
gem 'facebook-messenger'
gem 'wit'
gem 'workable', '~> 2.1.0'
gem 'nokogiri'
gem 'i18n'
gem 'faraday'
gem 'slim'

gem 'hanami-assets'
gem 'hanami-bootstrap'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
  gem 'foreman'
end

group :test, :development do
  gem 'pry'
  gem 'dotenv', '~> 2.0'
  gem 'vcr'
  gem 'webmock'
  gem 'factory_girl'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'database_cleaner'
end

group :production do
  # gem 'puma'
end
