require_dependency 'ui'

require_relative './support/test_attributes'

module UI
  RSpec.describe 'OrderList read model' do
    include TestAttributes

    specify 'create a new order' do
      read_model.call(order_registered)
      expect(read_model.all.size).to eq(1)
      assert_order_correct
    end

    private

    def assert_order_correct
      expect(first_order.uuid).to eq(order_dddproject[:uuid])
      expect(first_order.name).to eq(order_dddproject[:name])
    end

    def order_registered
      Accounting::OrderRegistered.new(data: {
        order_uuid:   order_dddproject[:uuid],
        project_uuid: order_dddproject[:project_uuid],
        order_name:   order_dddproject[:name]
      })
    end

    def read_model
      @order_list_read_model ||= UI::OrderListReadModel.new
    end

    def first_order
      read_model.all.first
    end
  end
end
