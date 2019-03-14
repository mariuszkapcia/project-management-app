require_dependency 'project_management'

require_relative '../support/test_attributes'

module ProjectManagement
  RSpec.describe 'Developers read model' do
    include TestAttributes

    specify 'list of developers' do
      event_store.publish(developer_registered, stream_name: 'stream_name')
      event_store.publish(developer_removed, stream_name: 'stream_name')

      read_model_builder.call(developer_registered)
      read_model_builder.call(developer_removed)
      developers = read_model_retriever.retrieve.developers

      expect(developers.size).to eq(1)
    end

    private

    def developer_registered
      @developer_registered ||= begin
        ProjectManagement::DeveloperRegistered.new(data: {
          developer_uuid: developer_ignacy[:uuid],
          fullname:       developer_ignacy[:fullname],
          email:          developer_ignacy[:email]
        })
      end
    end

    def developer_removed
      @developer_removed ||= begin
        ProjectManagement::DeveloperRemoved.new(data: {
          developer_uuid: developer_ignacy[:uuid]
        })
      end
    end

    def read_model_builder
      @read_model_builder ||= ProjectManagement::DeveloperList::Builder.new(event_store: event_store)
    end

    def read_model_retriever
      @read_model_retriever ||= ProjectManagement::DeveloperList::Retriever.new(event_store: event_store)
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
