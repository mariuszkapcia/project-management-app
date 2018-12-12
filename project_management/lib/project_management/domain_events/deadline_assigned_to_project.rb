module ProjectManagement
  class DeadlineAssignedToProject < RailsEventStore::Event
    SCHEMA = {
      uuid:     String,
      deadline: String
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
