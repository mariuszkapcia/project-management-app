# #TopSecretDDDProject

Simple application for managing projects. The main purpose is to show how to apply Domain-driven design, CQRS, and Event Sourcing techniques in a real project.

Available features:
- Add a new developer.
- Add a new project.
- Estimate the project.
- Assign deadline to the project.
- Assign developers to the project.
- Assign weekly working hours for each developer in the project.
- See approximate date of finishing the project.

Live demo available [here](https://limitless-forest-11376.herokuapp.com/).

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
