module ProjectManagement
  class Developer
    include AggregateRoot

    HasBeenAlreadyRegistered = Class.new(StandardError)
    EmailAddressNotUniq      = Class.new(StandardError)

    def initialize(uuid)
      @uuid = uuid
    end

    def register(fullname, email)
      raise HasBeenAlreadyRegistered if @state.equal?(:registered)

      apply(DeveloperRegistered.strict(data: {
        developer_uuid: @uuid,
        fullname:       fullname,
        email:          email
      }))
    end

    def remove
      return if @state.equal?(:removed)

      apply(DeveloperRemoved.strict(data: {
        developer_uuid: @uuid
      }))
    end

    private

    def apply_developer_registered(_event)
      @state = :registered
    end

    def apply_developer_removed(_event)
      @state = :removed
    end
  end
end
