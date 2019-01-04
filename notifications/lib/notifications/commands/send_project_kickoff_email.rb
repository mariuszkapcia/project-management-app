module Notifications
  class SendProjectKickoffEmail
    include Command

    attr_accessor :project_uuid
    attr_accessor :project_name

    validates :project_uuid, presence: { message: 'project_uuid_missing' },
                             format:   { with: UUID_REGEXP,
                                         message: 'incorrect_uuid' }
    validates :project_name, presence: { message: 'project_name_missing' }

    def initialize(project_uuid:, project_name:)
      @project_uuid = project_uuid
      @project_name = project_name
    end
  end
end
