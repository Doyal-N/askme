source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.3'
gem 'dotenv-rails'
gem 'puma', '~> 5.0'
gem 'rails-i18n'
gem 'pg'
gem 'webpacker', '~> 5.0'
gem 'slim-rails'
gem 'draper'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rubocop-rails', require: false
end
