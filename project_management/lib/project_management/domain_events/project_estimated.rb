module ProjectManagement
  class ProjectEstimated < RailsEventStore::Event
    SCHEMA = {
      project_uuid: String,
      hours:        Integer
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
