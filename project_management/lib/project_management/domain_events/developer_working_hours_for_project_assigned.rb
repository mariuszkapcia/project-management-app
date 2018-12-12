module ProjectManagement
  class DeveloperWorkingHoursForProjectAssigned < RailsEventStore::Event
    SCHEMA = {
      project_uuid:   String,
      developer_uuid: String,
      hours_per_week: Integer
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
