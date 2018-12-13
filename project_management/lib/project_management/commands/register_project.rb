module ProjectManagement
  class RegisterProject
    include Command

    attr_accessor :uuid
    attr_accessor :name

    validates :uuid, presence: { message: 'project_uuid_missing' },
                     format:   { with: UUID_REGEXP,
                                 message: 'incorrect_uuid' }
    validates :name, presence: { message: 'project_name_missing' }

    def initialize(uuid:, name:)
      @uuid = uuid
      @name = name
    end
  end
end
