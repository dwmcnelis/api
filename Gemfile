source 'https://rubygems.org'
ruby "2.2.0" 			# Use Ruby 2.2.0

gem 'rails', '4.2.0'		# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'pundit', '~> 0.3.0'	# Minimal authorization through OO design and pure Ruby classes
gem 'grape', '~> 0.10.1'	# An opinionated micro-framework for creating REST-like APIs in Ruby
# gem 'grape-active_model_serializers', '~> 1.3.1'	# Use ActiveModel::Serializers for JSON generation
gem 'grape-active_model_serializers', git: 'https://github.com/jrhe/grape-active_model_serializers.git', branch: 'master'
gem 'grape-swagger', '~> 0.9.0'	# Add swagger compliant documentation to your grape API
gem 'kaminari', '~> 0.16.2'	# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator
#gem 'mysql2', '~> 0.3.17'	# Use mysql2 as the database for Active Record
gem 'pg', '~> 0.18.1' # Use postgres as the database for Active Record
gem 'encrypted_strings', '~> 0.3.3' # Dead-simple string encryption/decryption
gem 'colorize', '~> 0.7.5'	# Text color using ANSI escape sequences
gem 'bcrypt'#, '~> 3.1.10'	# OpenBSD password hashing algorithm
gem 'rotp'#, '~> 2.1.0'		# One time passwords
gem 'jwt', '~> 1.2.1'		# JSON Web Tokens
gem 'dragonfly', '~> 1.0.7'	# On-the-fly processing of images and other attachments
#gem 'feedjira', '~> 1.6.0'	# Feed fetching and parsing
gem 'feedjira', git: 'git@github.com:feedjira/feedjira.git' # Feed parsing
gem 'rest-client', '~> 1.8.0'	# Simple HTTP and REST client

group :development do
  gem 'spring-commands-rspec' # Add 'rspec' command for Spring
end
group :development, :test do
  gem 'byebug'			# Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'web-console', '~> 2.0'	# Access an IRB console on exception pages or by using <%= console %> in views
  gem 'spring'			# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'factory_girl_rails', '~> 4.5.0' # Factory Girl ♥ Rails
  gem 'faker', '~> 1.4.3' # A library for generating fake data
  gem 'rspec-rails', '~> 3.2.0'# RSpec for Rails-3+
end
group :test do
  gem 'capybara', '~> 2.4.4' # Acceptance test framework for web applications
  gem 'database_cleaner', '~> 1.4.0' # Strategies for cleaning databases
  gem 'launchy', '~> 2.4.3' # Helper for launching cross-platform applications
  #gem 'selenium-webdriver', '~> 2.44.0'
  gem 'poltergeist', '1.6.0' # A PhantomJS driver for Capybara
  gem 'simplecov', '~> 0.9.1' # Code coverage for Ruby
end
