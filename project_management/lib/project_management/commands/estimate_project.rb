module ProjectManagement
  class EstimateProject
    include Command

    attr_accessor :project_uuid
    attr_accessor :hours

    validates :project_uuid,  presence: { message: 'project_uuid_missing' },
                              format:   { with: UUID_REGEXP,
                                          message: 'incorrect_uuid' }
    validates :hours,         presence: { message: 'project_hours_missing' }

    def initialize(project_uuid:, hours:)
      @project_uuid = project_uuid
      @hours        = hours
    end
  end
end
