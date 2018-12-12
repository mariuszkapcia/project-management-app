# Domain-driven design, CQRS, and Event Sorucing demo application

## Ruby version

2.5.0

## Configuration

### Install gems

```ruby
bundle install --path vendor/bundle
```

### Setup database
```ruby
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

## How to run the test suite

```ruby
bundle exec rspec spec
```
