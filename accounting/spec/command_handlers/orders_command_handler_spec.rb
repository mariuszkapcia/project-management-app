require_dependency 'accounting'

require_relative '../support/test_attributes'
require_relative '../support/test_actors'

module Accounting
  RSpec.describe 'OrdersCommandHandler' do
    include TestAttributes
    include TestActors

    specify 'register a new order' do
      order = instance_of_order(event_store: event_store)
      order.register(order_dddproject)

      expect(event_store).to(have_published(order_registered))
    end

    specify 'valuate the order' do
      order = instance_of_order(event_store: event_store)
      order.register(order_dddproject)
      order.valuate(order_dddproject[:amount_cents], order_dddproject[:amount_currency])

      expect(event_store).to(have_published(order_valuated))
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

    def event_store
      RailsEventStore::Client.new.tap do |es|
        ConfigureAccountingBoundedContext.new(event_store: es).call
      end
    end
  end
end
