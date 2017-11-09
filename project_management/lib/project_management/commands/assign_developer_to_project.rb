module ProjectManagement
  class AssignDeveloperToProject
    attr_accessor :project_uuid
    attr_accessor :developer_uuid
    attr_accessor :developer_fullname

    def initialize(project_uuid:, developer_uuid:, developer_fullname:)
      @project_uuid       = project_uuid
      @developer_uuid     = developer_uuid
      @developer_fullname = developer_fullname
    end
  end
end
