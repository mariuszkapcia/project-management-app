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

  class ProjectEstimatedV2 < RailsEventStore::Event
    SCHEMA = {
      project_uuid: String,
      hours:        Integer,
      story_points: Integer
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
