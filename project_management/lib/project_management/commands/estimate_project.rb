module ProjectManagement
  class EstimateProject
    include Command

    attr_accessor :uuid
    attr_accessor :hours

    validates :uuid,  presence: { message: 'project_uuid_missing' },
                      format:   { with: UUID_REGEXP,
                                  message: 'incorrect_uuid' }
    validates :hours, presence: { message: 'project_hours_missing' }

    def initialize(uuid:, hours:)
      @uuid  = uuid
      @hours = hours
    end
  end
end
