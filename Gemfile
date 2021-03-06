source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6.1'
# Use SCSS for stylesheets
gem 'slim-rails'
gem 'sass-rails', '~> 5.0'
gem 'i18n-tasks'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'omniauth'
gem 'omniauth-twitter'
gem 'hashie', '~> 3.4.6'

gem 'react-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'kaminari'

gem 'rubimas'
gem 'active_hash'

gem 'browserify-rails'

gem 'aws-sdk'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'puma'
  gem 'pg'
  gem 'rails_12factor'
end

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'timecop'
end

group :development do
  gem 'annotate'
  gem 'pry'
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
  gem 'factory_girl_rails'
  gem 'database_rewinder'
end

gem 'influxdb-rails', github: 'influxdata/influxdb-rails'
gem 'influxdb'
gem 'her'

gem 'nokogiri', '>= 1.8.5'

gem 'rails-html-sanitizer', '~> 1.0.3'
gem 'ffi', '>= 1.9.24'
gem 'loofah', '>= 2.2.3'
