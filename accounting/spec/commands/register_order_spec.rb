require_dependency 'accounting'

require_relative '../support/test_attributes'

module Accounting
  RSpec.describe 'RegisterOrder command' do
    include TestAttributes

    specify 'should validate presence of order_uuid' do
      cmd = Accounting::RegisterOrder.new(
        order_uuid:   nil,
        project_uuid: order_dddproject[:project_uuid],
        project_name: order_dddproject[:name]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of order_uuid' do
      cmd = Accounting::RegisterOrder.new(
        order_uuid:   'wrong_uuid_format',
        project_uuid: order_dddproject[:project_uuid],
        project_name: order_dddproject[:name]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of project_uuid' do
      cmd = Accounting::RegisterOrder.new(
        order_uuid:   order_dddproject[:uuid],
        project_uuid: nil,
        project_name: order_dddproject[:name]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of project_uuid' do
      cmd = Accounting::RegisterOrder.new(
        order_uuid:   order_dddproject[:uuid],
        project_uuid: 'wrong_uuid_format',
        project_name: order_dddproject[:name]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of project_name' do
      cmd = Accounting::RegisterOrder.new(
        order_uuid:   order_dddproject[:uuid],
        project_uuid: order_dddproject[:project_uuid],
        project_name: nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end
  end
end
