module ProjectManagement
  class OrderList::Retriever
    def retrieve
      @state = reply_state
      self
    end

    def orders
      @state.orders
    end

    def find(order_uuid)
      @state.orders.find { |order| order[:uuid] == order_uuid }
    end

    private

    def initialize(event_store:)
      @event_store = event_store
    end

    def reply_state
      all_events_in(stream_name).each_with_object(OrderList::State.new) do |event, state|
        state.reply(event)
      end
    end

    def all_events_in(stream_name)
      @event_store.read.stream(stream_name).each.to_a
    end

    def stream_name
      'ProjectManagement::OrderListReadModel'
    end
  end
end
