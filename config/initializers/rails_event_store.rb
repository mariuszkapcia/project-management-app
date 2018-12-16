require_relative '../event_store/configure_accounting_bounded_context'
require_relative '../event_store/configure_project_management_bounded_context'
require_relative '../event_store/configure_ui_bounded_context'

require_relative '../event_store/configure_project_management_accounting_mapping'

Rails.configuration.to_prepare do
  Rails.configuration.event_store.tap do |es|
    ConfigureProjectManagementBoundedContext.new(event_store: es).call
    ConfigureProjectManagementAccountingMapping.new(event_store: es).call
    ConfigureAccountingBoundedContext.new(event_store: es).call
    ConfigureUIBoundedContext.new(event_store: es).call
  end
end
