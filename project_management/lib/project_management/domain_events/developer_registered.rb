module ProjectManagement
  class DeveloperRegistered < RailsEventStore::Event
    SCHEMA = {
      uuid:     String,
      fullname: String,
      email:    String
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end
  end
end
