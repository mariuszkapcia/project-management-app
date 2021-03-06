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
- [feature/event-versioning] Sample implementation of event upcaster as RES mapper. To make this possible I needed to introduce `ComposedMapper`. Thanks to that I'm able to pass list of mappers to the RES client.
- [feature/gdpr-event-encryption] Sample implementation of GDPR in event sourced system. Sensitive data is encrypted with `EncryptionMapper` from RES.
- [feature/command-sourcing] Sample implementation of command sourcing pattern. Commands are stored in simple `CommandStore` and there is a rake task for replaying the whole system from commands.

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
