source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


group :development, :test do
  gem 'sqlite3'  
end
group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# use Haml for templates
gem 'haml'
gem 'haml-rails'


# use Ruby debugger
group :development, :test do
  gem 'ruby-debug19'
end

group :test do
gem 'cucumber', '1.1.3'
gem 'rspec-expectations', '2.7.0'
end
