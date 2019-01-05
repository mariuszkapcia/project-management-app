module ProjectManagement
  class RegisterProject
    include Command

    attr_accessor :project_uuid
    attr_accessor :name

    validates :project_uuid, presence: { message: 'project_uuid_missing' },
                             format:   { with: UUID_REGEXP,
                                         message: 'incorrect_uuid' }
    validates :name,         presence: { message: 'project_name_missing' }

    def initialize(project_uuid:, name:)
      @project_uuid = project_uuid
      @name         = name
    end
  end
end
