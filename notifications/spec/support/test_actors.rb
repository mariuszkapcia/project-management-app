require_relative './actors/test_system'

module Notifications
  module TestActors
    def instance_of_system(**kwargs)
      TestSystem.new(kwargs)
    end
  end
end
