require 'aggreagte_root'

module Assignments
  class Project
    include AggreagteRoot

    def initialize(uuid)
      @uuid = uuid
    end
  end
end
