module Accounting
  class RegisterOrder
    include Command

    attr_accessor :order_uuid
    attr_accessor :project_uuid
    attr_accessor :project_name

    validates :order_uuid,   presence: { message: 'order_uuid_missing' },
                             format:   { with: UUID_REGEXP,
                                         message: 'incorrect_uuid' }
    validates :project_uuid, presence: { message: 'project_uuid_missing' },
                             format:   { with: UUID_REGEXP,
                                         message: 'incorrect_uuid' }
    validates :project_name, presence: { message: 'project_name_missing' }

    def initialize(order_uuid:, project_uuid:, project_name:)
      @order_uuid   = order_uuid
      @project_uuid = project_uuid
      @project_name = project_name
    end
  end
end
