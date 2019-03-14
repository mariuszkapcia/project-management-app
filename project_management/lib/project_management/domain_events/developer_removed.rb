module ProjectManagement
  class DeveloperRemoved < RailsEventStore::Event
    SCHEMA = {
      developer_uuid: String
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
