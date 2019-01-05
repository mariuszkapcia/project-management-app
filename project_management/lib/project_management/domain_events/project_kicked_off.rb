module ProjectManagement
  class ProjectKickedOff < RailsEventStore::Event
    SCHEMA = {
      project_uuid: String
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
