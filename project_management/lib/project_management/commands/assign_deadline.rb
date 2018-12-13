module ProjectManagement
  class AssignDeadline
    include Command

    attr_accessor :project_uuid
    attr_accessor :deadline

    validates :project_uuid, presence: { message: 'project_uuid_missing' },
                             format:   { with: UUID_REGEXP,
                                         message: 'incorrect_uuid' }
    validates :deadline,     presence: { message: 'project_deadline_missing' }

    def initialize(project_uuid:, deadline:)
      @project_uuid  = project_uuid
      @deadline      = deadline
    end
  end
end
