module Accounting
  class TestOrder
    def register(order)
      @uuid = order[:uuid]

      @command_handler
        .new(event_store: @event_store)
        .call(
          Accounting::RegisterOrder.new(
            order_uuid:   order[:uuid],
            project_uuid: order[:project_uuid],
            project_name: order[:name]
          )
        )
    end

    def valuate(amount, currency)
      @command_handler
        .new(event_store: @event_store)
        .call(
          Accounting::ValuateOrder.new(
            order_uuid: @uuid,
            amount:     amount,
            currency:   currency
          )
        )
    end

    private

    def initialize(event_store: Rails.configuration.event_store)
      @uuid            = nil
      @event_store     = event_store
      @command_handler = Accounting::OrdersCommandHandler
    end
  end
end
