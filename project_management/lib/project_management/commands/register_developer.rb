module ProjectManagement
  class RegisterDeveloper
    include Command

    attr_accessor :uuid
    attr_accessor :fullname
    attr_accessor :email

    validates :uuid,     presence: { message: 'developer_uuid_missing' },
                         format:   { with: UUID_REGEXP,
                                     message: 'incorrect_uuid' }
    validates :fullname, presence: { message: 'developer_fullname_missing' }
    validates :email,    presence: { message: 'developer_email_missing' },
                         format:   { with: EMAIL_REGEXP,
                                     message: 'developer_email_incorrect' }

    def initialize(uuid:, fullname:, email:)
      @uuid     = uuid
      @fullname = fullname
      @email    = email
    end
  end
end
