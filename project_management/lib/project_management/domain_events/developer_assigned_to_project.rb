module ProjectManagement
  class DeveloperAssignedToProject < RailsEventStore::Event
    SCHEMA = {
      developer_uuid:     String,
      project_uuid:       String,
      developer_fullname: String
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
