module ProjectManagement
  class RegisterDeveloper
    attr_accessor :uuid
    attr_accessor :fullname
    attr_accessor :email

    def initialize(uuid:, fullname:, email:)
      @uuid     = uuid
      @fullname = fullname
      @email    = email
    end
  end
end
