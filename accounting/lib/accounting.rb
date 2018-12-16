module Accounting
end

require_dependency 'accounting/aggregates/order.rb'

require_dependency 'accounting/command_handlers/orders_command_handler.rb'

require_dependency 'accounting/commands/register_order.rb'
require_dependency 'accounting/commands/valuate_order.rb'

require_dependency 'accounting/domain_events/order_registered.rb'
require_dependency 'accounting/domain_events/order_valuated.rb'

require_dependency 'accounting/value_objects/amount.rb'
