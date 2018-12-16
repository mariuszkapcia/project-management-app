# TODO: Make this handler async
module ProjectManagementAccountingMapping
  class ProjectRegisteredHandler
    def call(event)
      Accounting::OrdersCommandHandler
        .new(event_store: event_store)
        .call(
          Accounting::RegisterOrder.new(
            order_uuid:   SecureRandom.uuid,
            project_uuid: event.data[:uuid],
            project_name: event.data[:name]
          )
        )
    end

    private

    def event_store
      Rails.configuration.event_store
    end
  end
end
