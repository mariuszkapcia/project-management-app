module ProjectManagement
  class RegisterDeveloper
    include Command

    attr_accessor :developer_uuid
    attr_accessor :fullname
    attr_accessor :email

    validates :developer_uuid, presence: { message: 'developer_uuid_missing' },
                               format:   { with: UUID_REGEXP,
                                           message: 'incorrect_uuid' }
    validates :fullname,       presence: { message: 'developer_fullname_missing' }
    validates :email,          presence: { message: 'developer_email_missing' },
                               format:   { with: EMAIL_REGEXP,
                                           message: 'developer_email_incorrect' }

    def initialize(developer_uuid:, fullname:, email:)
      @developer_uuid = developer_uuid
      @fullname       = fullname
      @email          = email
    end
  end
end
