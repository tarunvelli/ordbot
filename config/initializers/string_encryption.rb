class String
  def encrypt
    key = Base64.decode64(ENV['CIPHER_KEY'])
    crypt = ActiveSupport::MessageEncryptor.new(key)
    encrypted_message = crypt.encrypt_and_sign(self)
    Base64.urlsafe_encode64(encrypted_message)
  end

  def decrypt
    decoded_message = Base64.urlsafe_decode64(self)
    key = Base64.decode64(ENV['CIPHER_KEY'])
    crypt = ActiveSupport::MessageEncryptor.new(key)
    crypt.decrypt_and_verify(decoded_message)
  end
end
