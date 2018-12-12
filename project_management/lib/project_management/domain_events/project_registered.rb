module ProjectManagement
  class ProjectRegistered < RailsEventStore::Event
    SCHEMA = {
      uuid: String,
      name: String
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
