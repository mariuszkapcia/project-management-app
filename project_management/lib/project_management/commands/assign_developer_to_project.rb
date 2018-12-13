module ProjectManagement
  class AssignDeveloperToProject
    include Command

    attr_accessor :project_uuid
    attr_accessor :developer_uuid
    attr_accessor :developer_fullname

    validates :project_uuid,       presence: { message: 'project_uuid_missing' },
                                   format:   { with: UUID_REGEXP,
                                               message: 'incorrect_uuid' }
    validates :developer_uuid,     presence: { message: 'developer_uuid_missing' },
                                   format:   { with: UUID_REGEXP,
                                               message: 'incorrect_uuid' }
    validates :developer_fullname, presence: { message: 'developer_fullname_missing' }

    def initialize(project_uuid:, developer_uuid:, developer_fullname:)
      @project_uuid       = project_uuid
      @developer_uuid     = developer_uuid
      @developer_fullname = developer_fullname
    end
  end
end
