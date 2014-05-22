#source 'http://ruby.taobao.org'
ruby '2.0.0'
source 'http://rubygems.org'
group :production do
  gem 'sinatra'
  gem 'wei-backend', '0.1.4'
  gem 'httparty'
  gem 'mongo_mapper'
  gem 'bson_ext'
  gem 'rufus-scheduler'
end

group :development do
  gem 'shotgun', '~> 0.9'
  gem 'capistrano', '~> 3.0.1'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
  gem 'aws-sdk'
end

group :test do
  gem 'rspec'
  gem 'rack-test'
end
