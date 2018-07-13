source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'clipboard-rails'

gem 'capistrano3-delayed-job'

gem 'capistrano-passenger'

gem 'capistrano-rvm'

gem 'pg', group: :production

gem "selectize-rails"

gem 'dotenv-rails', groups: [:development, :test]

gem 'nested_form_fields'

gem 'omniauth-google-oauth2'

gem "paranoia", "~> 2.2"

gem 'progress_job'

gem "mini_magick"

gem 'carrierwave_backgrounder'

gem 'daemons'

gem 'delayed_job_active_record'

#ransak is useful for search
gem 'ransack'

#kaminari is useful for pagination
gem 'kaminari'

# Friendly_id hidden the id of objects with a their name or title or other fields
gem 'friendly_id', '~> 5.1.0'

# Gems globalize and activemodel work in concert for translate entities, such as posts or tools
gem 'globalize', '~> 5.1.0.beta2'
gem 'activemodel-serializers-xml'

#Font-awesome is a library of icons
gem "font-awesome-rails"

# Gem i18n stands for internationalization, it is useful for manage languages
gem 'rails-i18n'

# Bootstrap is useful for better style of components (ex buttons, input fields, ecc...)
gem 'bootstrap', '~> 4.0.0.beta3'

# Carrierwave is useful for file storage (ex: photos, documents, ecc...)
gem 'carrierwave'

# Devise is useful for sign-up and log-in and this gem control all authorization
gem 'devise'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.6'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-rails", "~> 1.3", require: false
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
