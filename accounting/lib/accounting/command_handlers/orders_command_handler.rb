module Accounting
  class OrdersCommandHandler
    def initialize(event_store:)
      @event_store = event_store
      @command_bus = Arkency::CommandBus.new
      {
        Accounting::RegisterOrder => method(:register_order),
        Accounting::ValuateOrder  => method(:valuate_order)
      }.map{ |klass, handler| @command_bus.register(klass, handler) }
    end

    def call(*commands)
      commands.each do |command|
        @command_bus.call(command)
      end
    end

    private

    def register_order(cmd)
      cmd.verify!

      ActiveRecord::Base.transaction do
        with_order(cmd.order_uuid) do |order|
          order.register(cmd.project_uuid, cmd.project_name)
        end
      end
    end

    def valuate_order(cmd)
      cmd.verify!

      amount = Amount.new(cmd.amount, cmd.currency)

      ActiveRecord::Base.transaction do
        with_order(cmd.order_uuid) do |order|
          order.valuate(amount)
        end
      end
    end

    def with_order(uuid)
      Accounting::Order.new(uuid).tap do |order|
        load_order(uuid, order)
        yield order
        store_order(order)
      end
    end

    def load_order(order_uuid, order)
      order.load(stream_name(order_uuid), event_store: @event_store)
    end

    def store_order(order)
      order.store(event_store: @event_store)
    end

    def stream_name(order_uuid)
      "Accounting::Order$#{order_uuid}"
    end
  end
end
