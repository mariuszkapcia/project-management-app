module ProjectManagement
  class EstimateProject
    attr_accessor :uuid
    attr_accessor :hours

    def initialize(uuid:, hours:)
      @uuid  = uuid
      @hours = hours
    end
  end
end
