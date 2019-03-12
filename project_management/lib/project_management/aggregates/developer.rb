module ProjectManagement
  class Developer
    include AggregateRoot

    HasBeenAlreadyRegistered = Class.new(StandardError)
    EmailAddressNotUniq      = Class.new(StandardError)

    def initialize(uuid)
      @uuid = uuid
    end

    def register(fullname, email)
      raise HasBeenAlreadyRegistered if @registered

      apply(DeveloperRegistered.strict(data: {
        developer_uuid: @uuid,
        fullname:       fullname,
        email:          email
      }))
    end

    private

    def apply_developer_registered(_event)
      @registered = true
    end
  end
end
