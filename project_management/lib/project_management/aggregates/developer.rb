module ProjectManagement
  class Developer
    include AggregateRoot

    HasBeenAlreadyRegistered = Class.new(StandardError)

    def initialize(uuid)
      @uuid  = uuid
      @state = nil
    end

    def register(fullname, email)
      raise HasBeenAlreadyRegistered if @state == :registered

      apply(ProjectManagement::DeveloperRegistered.strict(data: {
        uuid:     @uuid,
        fullname: fullname,
        email:    email
      }))
    end

    private

    def apply_developer_registered(event)
      @state = :registered
    end
  end
end
