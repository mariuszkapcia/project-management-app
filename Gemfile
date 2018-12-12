source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.7'

group :development, :test do
  gem 'pry-byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.7', '>= 3.7.1'
  gem 'rails_event_store-rspec', '~> 0.35.0'
  gem 'database_cleaner', '~> 1.6', '>= 1.6.2', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'rails_event_store', '~> 0.35.0'
gem 'arkency-command_bus', '~> 0.4.0'
gem 'sprockets', '~> 3.7', '>= 3.7.2'
