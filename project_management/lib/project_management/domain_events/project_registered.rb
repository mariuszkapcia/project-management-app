module ProjectManagement
  class ProjectRegistered < RailsEventStore::Event
    SCHEMA = {
      project_uuid: String,
      name:         String
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
