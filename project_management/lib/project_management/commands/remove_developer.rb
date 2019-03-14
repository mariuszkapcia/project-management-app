module ProjectManagement
  class RemoveDeveloper
    include Command

    attr_accessor :developer_uuid

    validates :developer_uuid, presence: { message: 'developer_uuid_missing' },
                               format:   { with: UUID_REGEXP,
                                           message: 'incorrect_uuid' }

    def initialize(developer_uuid:)
      @developer_uuid = developer_uuid
    end
  end
end
