class EncryptionKeyRepository
  DEFAULT_CIPHER = 'aes-256-cbc'.freeze

  def key_of(identifier, cipher: DEFAULT_CIPHER)
    key = EncryptionKey.where(identifier: identifier, cipher: cipher).take.try(:key)
    return nil unless key

    RubyEventStore::Mappers::EncryptionKey.new(
      cipher: cipher,
      key:    key
    )
  end

  def create(identifier, cipher: DEFAULT_CIPHER)
    EncryptionKey.where(
      identifier: identifier,
      cipher:     cipher
    ).first_or_create!(
      key: random_key(cipher)
    )
  end

  def forget(identifier)
    EncryptionKey.where(identifier: identifier).destroy_all
  end

  def delete_all
    EncryptionKey.destroy_all
  end

  private

  def random_key(cipher)
    crypto = OpenSSL::Cipher.new(cipher)
    crypto.encrypt
    crypto.random_key
  end
end
