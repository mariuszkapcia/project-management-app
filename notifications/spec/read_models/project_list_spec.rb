require_dependency 'notifications'

require_relative '../support/test_attributes'

module Notifications
  RSpec.describe 'ProjectList read model' do
    include TestAttributes

    specify 'list of projects' do
      event_store.publish(project_registered, stream_name: 'stream_name')

      read_model_builder.call(project_registered)
      projects = read_model_retriever.retrieve.projects

      expect(projects.size).to eq(1)
    end

    private

    def project_registered
      @project_registered ||= begin
        ProjectManagement::ProjectRegistered.new(data: {
          project_uuid: project_topsecretdddproject[:uuid],
          name:         project_topsecretdddproject[:name]
        })
      end
    end

    def read_model_builder
      @read_model_builder ||= Notifications::ProjectList::Builder.new(event_store: event_store)
    end

    def read_model_retriever
      @read_model_retriever ||= Notifications::ProjectList::Retriever.new(event_store: event_store)
    end

    def event_store
      @event_store ||= begin
        RailsEventStore::Client.new(
          repository: RubyEventStore::InMemoryRepository.new
        )
      end
    end
  end
end
