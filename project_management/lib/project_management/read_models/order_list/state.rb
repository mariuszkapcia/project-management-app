module ProjectManagement
  class OrderList::State
    def reply(event)
      handler = map_event_to_handler(event.class)
      send(handler, event)
    end

    def orders
      @orders
    end

    private

    def initialize
      @orders = []
    end

    def map_event_to_handler(event_class)
      {
        'Accounting::OrderRegistered' => :apply_order_registered
      }.fetch(event_class.to_s)
    end

    def apply_order_registered(event)
      @orders << {
        uuid:         event.data[:order_uuid],
        project_uuid: event.data[:project_uuid]
      }
    end
  end
end
