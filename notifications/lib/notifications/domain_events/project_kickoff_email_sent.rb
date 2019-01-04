module Notifications
  class ProjectKickoffEmailSent < RailsEventStore::Event
    SCHEMA = {
      project_uuid: String,
      project_name: String
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
