module ProjectManagement
  class DeveloperRemovedListener
    def call(event)
      encryption_key_repository = EncryptionKeyRepository.new
      encryption_key_repository.forget(event.data[:developer_uuid])
    end
  end
end
