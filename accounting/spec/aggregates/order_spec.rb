require_dependency 'accounting'

require_relative '../support/test_attributes'

module Accounting
  RSpec.describe 'Order aggregate' do
    include TestAttributes

    specify 'register a new order' do
      order = Accounting::Order.new(order_dddproject[:uuid])
      order.register(order_dddproject[:project_uuid], order_dddproject[:name])

      expect(order).to(have_applied(order_registered))
    end

    specify 'order cannot be registered twice' do
      order = Accounting::Order.new(order_dddproject[:uuid])
      order.register(order_dddproject[:project_uuid], order_dddproject[:name])

      expect do
        order.register(order_dddproject[:project_uuid], order_dddproject[:name])
      end.to raise_error(Accounting::Order::HasBeenAlreadyRegistered)
    end

    specify 'valuate the order' do
      order = Accounting::Order.new(order_dddproject[:uuid])
      order.register(order_dddproject[:project_uuid], order_dddproject[:name])

      amount = Amount.new(order_dddproject[:amount_cents], order_dddproject[:amount_currency])
      order.valuate(amount)

      expect(order).to(have_applied(order_valuated))
    end

    specify 'cannot valuate order with negative amount' do
      order = Accounting::Order.new(order_dddproject[:uuid])
      order.register(order_dddproject[:project_uuid], order_dddproject[:name])

      expect do
        order.valuate(-1)
      end.to raise_error(Accounting::Order::InvalidAmount)
    end

    private

    def order_registered
      an_event(Accounting::OrderRegistered).with_data(order_registered_data).strict
    end

    def order_valuated
      an_event(Accounting::OrderValuated).with_data(order_valuated_data).strict
    end

    def order_registered_data
      {
        order_uuid:   order_dddproject[:uuid],
        project_uuid: order_dddproject[:project_uuid],
        order_name:   order_dddproject[:name]
      }
    end

    def order_valuated_data
      {
        order_uuid: order_dddproject[:uuid],
        amount:     order_dddproject[:amount_cents],
        currency:   order_dddproject[:amount_currency]
      }
    end
  end
end
