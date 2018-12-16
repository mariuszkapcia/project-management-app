module Accounting
  class Order
    include AggregateRoot

    HasBeenAlreadyRegistered = Class.new(StandardError)
    InvalidAmount            = Class.new(StandardError)

    def initialize(uuid)
      @uuid         = uuid
      @state        = nil
      @project_uuid = nil
    end

    def register(project_uuid, project_name)
      raise HasBeenAlreadyRegistered if @state == :registered

      apply(Accounting::OrderRegistered.strict(data: {
        order_uuid:   @uuid,
        order_name:   project_name,
        project_uuid: project_uuid
      }))
    end

    def valuate(amount)
      raise InvalidAmount if amount.negative?

      apply(Accounting::OrderValuated.strict(data: {
        order_uuid: @uuid,
        amount:     amount.hash[:cents],
        currency:   amount.hash[:currency]
      }))
    end

    private

    def apply_order_registered(event)
      @state        = :registered
      @project_uuid = event.data[:project_uuid]
    end

    def apply_order_valuated(event)
    end
  end
end
