require_dependency 'project_management'

require_relative '../support/test_attributes'
require_relative '../support/test_actors'

module ProjectManagement
  RSpec.describe 'DeveloperRemoved listener' do
    include TestAttributes
    include TestActors

    specify 'encryption key is removed' do
      encryption_key_repository = EncryptionKeyRepository.new
      encryption_key_repository.create(developer_ignacy[:uuid])

      DeveloperRemovedListener.new.call(developer_removed)

      expect(encryption_key_repository.key_of(developer_ignacy[:uuid])).to eq(nil)
    end

    private

    def developer_removed
      DeveloperRemoved.new(data: {
        developer_uuid: developer_ignacy[:uuid]
      })
    end
  end
end
