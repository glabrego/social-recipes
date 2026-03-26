source 'https://rubygems.org'

gem 'rails', '8.1.2'
gem 'sqlite3', '~> 2.1', group: [:development, :test]
gem 'propshaft'
gem 'importmap-rails'
gem 'turbo-rails', '~> 2.0'
gem 'cloudinary', '~> 2.4'
gem 'devise', '~> 5.0'
gem 'puma', '~> 7.1'

group :development, :test do
  gem 'debug'
  gem 'rspec-rails', '~> 8.0'
  gem 'factory_bot_rails', '~> 6.5'
  gem 'rubocop', '~> 1.63', require: false
  gem 'rubocop-rails', '~> 2.25', require: false
  gem 'capybara', '~> 3.40'
  gem 'simplecov', require: false
end

group :production do
  gem 'pg', '~> 1.6'
end
