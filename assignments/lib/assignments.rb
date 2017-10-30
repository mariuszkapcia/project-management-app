module Assignments
  class RegisterProject
    attr_accessor :uuid
    attr_accessor :name

    def initialize(uuid, name)
      @uuid = uuid
      @name = name
    end
  end
end
