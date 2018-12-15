module Accounting
  class OrderValuated < RailsEventStore::Event
    SCHEMA = {
      order_uuid:   String,
      amount:       Integer
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
