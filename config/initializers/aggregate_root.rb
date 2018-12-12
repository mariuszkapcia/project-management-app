require 'aggregate_root'

Rails.configuration.to_prepare do
  AggregateRoot.configure do |config|
    config.default_event_store = Rails.configuration.event_store
  end
end
