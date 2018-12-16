module UI
  class OrderListReadModel
    def call(event)
      case event
        when Accounting::OrderRegistered
          create_order(event.data[:order_uuid], event.data[:order_name])
      end
    end

    def all
      UI::OrderList::Order.all
    end

    def find(uuid)
      UI::OrderList::Order.find(uuid)
    end

    private

    def create_order(order_uuid, order_name)
      UI::OrderList::Order.create!(uuid: order_uuid, name: order_name)
    end
  end
end
