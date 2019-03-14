require_dependency 'ui'

require_relative './support/test_attributes'

module UI
  RSpec.describe 'Developers read model' do
    include TestAttributes

    specify 'creates developer' do
      read_model.call(developer_registered)
      expect(read_model.all.size).to eq(1)
      assert_developer_correct
    end

    specify 'remove developer' do
      read_model.call(developer_registered)
      read_model.call(developer_removed)
      expect(read_model.all.size).to eq(0)
    end

    private

    def assert_developer_correct
      expect(first_developer.uuid).to eq(developer_ignacy[:uuid])
      expect(first_developer.fullname).to eq(developer_ignacy[:fullname])
      expect(first_developer.email).to eq(developer_ignacy[:email])
    end

    def developer_registered
      ProjectManagement::DeveloperRegistered.new(data: {
        developer_uuid: developer_ignacy[:uuid],
        fullname:       developer_ignacy[:fullname],
        email:          developer_ignacy[:email]
      })
    end

    def developer_removed
      ProjectManagement::DeveloperRemoved.new(data: {
        developer_uuid: developer_ignacy[:uuid]
      })
    end

    def read_model
      @developer_list_read_model ||= UI::DeveloperListReadModel.new
    end

    def first_developer
      read_model.all.first
    end
  end
end
