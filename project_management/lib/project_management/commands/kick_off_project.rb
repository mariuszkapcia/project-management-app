module ProjectManagement
  class KickOffProject
    include Command

    attr_accessor :project_uuid

    validates :project_uuid, presence: { message: 'project_uuid_missing' },
                             format:   { with: UUID_REGEXP,
                                         message: 'incorrect_uuid' }

    def initialize(project_uuid:)
      @project_uuid = project_uuid
    end
  end
end
