namespace :accounting do
  desc 'Reply project_registered_handler from project_management_accounting mapping.'
  task reply_project_registered_handler: :environment do
    event_store = Rails.configuration.event_store
    projection  = RailsEventStore::Projection
      .from_all_streams
      .init( -> {})
      .when(
        [
          ProjectManagement::ProjectRegistered
        ],
        ->(state, event) { ProjectManagementAccountingMapping::ProjectRegisteredHandler.new.call(event) }
      )

    projection.run(event_store)
  end
end
