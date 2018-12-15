require_dependency 'accounting'

require_relative '../support/test_attributes'

module Accounting
  RSpec.describe 'ValuateOrder command' do
    include TestAttributes

    specify 'should validate presence of order_uuid' do
      cmd = Accounting::ValuateOrder.new(
        order_uuid: nil,
        amount:     order_dddproject[:name]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of order_uuid' do
      cmd = Accounting::ValuateOrder.new(
        order_uuid: 'wrong_uuid_format',
        amount:     order_dddproject[:name]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of amount' do
      cmd = Accounting::ValuateOrder.new(
        order_uuid: order_dddproject[:uuid],
        amount:     nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end
  end
end
