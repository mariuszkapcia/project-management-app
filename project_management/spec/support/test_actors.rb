require_relative './actors/test_developer'
require_relative './actors/test_project'

module ProjectManagement
  module TestActors
    def instance_of_developer(**kwargs)
      TestDeveloper.new(kwargs)
    end

    def instance_of_project(**kwargs)
      TestProject.new(kwargs)
    end
  end
end
