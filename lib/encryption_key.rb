class EncryptionKey < ActiveRecord::Base
  def encrypt(message, iv: nil)
    crypto = OpenSSL::Cipher.new(cipher)
    crypto.encrypt
    crypto.iv  = iv || self.iv
    crypto.key = key
    crypto.update(message) + crypto.final
  end

  def decrypt(message, iv: nil)
    crypto = OpenSSL::Cipher.new(cipher)
    crypto.decrypt
    crypto.iv  = iv || self.iv
    crypto.key = key
    (crypto.update(message) + crypto.final).force_encoding('UTF-8')
  end
end
