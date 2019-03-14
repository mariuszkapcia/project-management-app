module ProjectManagement
  class DeveloperRegistered < RailsEventStore::Event
    SCHEMA = {
      developer_uuid: String,
      fullname:       String,
      email:          String
    }.freeze

    def self.strict(data:)
      ClassyHash.validate(data, SCHEMA)
      new(data: data)
    end

    def self.encryption_schema
      {
        fullname: ->(data) { data.fetch(:developer_uuid) },
        email:    ->(data) { data.fetch(:developer_uuid) }
      }
    end
  end
end
