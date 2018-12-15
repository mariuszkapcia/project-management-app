module Accounting
  class OrderRegistered < RailsEventStore::Event
    SCHEMA = {
      order_uuid:   String,
      order_name:   String,
      project_uuid: String
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
