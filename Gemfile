source 'https://rubygems.org'

gem 'rails', '4.0.2'

# Use postgreSQL as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby'

# Use RedCloth for converting posts into HTML
gem 'RedCloth'

# Use twitter-bootstrap-rails-cdn to fetch bootstrap assets
gem 'twitter-bootstrap-rails-cdn'

# Use rspec-rails for testing
group :development, :test do
  gem 'rspec-rails', '~> 2.14.0'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'fuubar'
end

# Development gems
group :development do
	# Fix for https://github.com/leehambley/sshkit/issues/39
	gem 'sshkit', github: 'leehambley/sshkit', require: false
	gem 'capistrano', '~> 3.0.1', require: false
	gem 'capistrano-rails', '~> 1.0.0', require: false
	gem 'capistrano-rbenv', github: 'capistrano/rbenv', require: false
	gem 'capistrano-bundler', '~> 1.0.0', require: false
end
