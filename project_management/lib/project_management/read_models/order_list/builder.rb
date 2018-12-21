module ProjectManagement
  module OrderList
    class Builder
      def call(event)
        @event_store.link(event.event_id, stream_name: stream_name)
      end

      private

      def initialize(event_store:)
        @event_store = event_store
      end

      def stream_name
        'ProjectManagement::OrderListReadModel'
      end
    end
  end
end
