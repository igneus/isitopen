ruby '2.1.1'

source 'https://rubygems.org'

# Rails default gems
gem 'rails', '4.0.2'
gem 'sqlite3'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# user authentication
gem 'omniauth'
gem 'omniauth-facebook', '1.4.0'

gem "econfig", require: "econfig/rails"

group :development do
  gem 'rspec-rails'
  gem 'capistrano'
  gem 'capistrano-rails', '~> 1.1'

  # This gem is very useful for deployment, but has funny side-effects:
  # for unknown reasons, it causes rails crash when executing
  # commands like 'rails s'; it helps to comment it out
  gem 'rvm1-capistrano3'
end
