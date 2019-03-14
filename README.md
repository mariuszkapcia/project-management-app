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
- Send project kickoff notification when deadline and estimation are provided.

Live demo available [here](https://project-management-ddd.herokuapp.com/).

Feature branches:
- [feature/event_versioning] Sample implementation of event upcaster as RES mapper. To make this possible I needed to introduce `ComposedMapper`. Thanks to that I'm able to pass list of mappers to the RES client.

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
