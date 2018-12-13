module ProjectManagement
  class AssignDeveloperWorkingHours
    include Command

    attr_accessor :project_uuid
    attr_accessor :developer_uuid
    attr_accessor :hours_per_week

    validates :project_uuid,       presence: { message: 'project_uuid_missing' },
                                   format:   { with: UUID_REGEXP,
                                               message: 'incorrect_uuid' }
    validates :developer_uuid,     presence: { message: 'developer_uuid_missing' },
                                   format:   { with: UUID_REGEXP,
                                               message: 'incorrect_uuid' }
    validates :hours_per_week, presence: { message: 'developer_hours_per_week_missing' }

    def initialize(project_uuid:, developer_uuid:, hours_per_week:)
      @project_uuid   = project_uuid
      @developer_uuid = developer_uuid
      @hours_per_week = hours_per_week
    end
  end
end
