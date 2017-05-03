class AccessTokens::CreateService
  attr_reader :user

  def initialize(user:)
    @user = user
  end

  def call
    new_token = user.access_tokens.create(
      token_value: generate_token,
      device_id: generate_device_id
    )
  end

  # Plaintext token_value. Encrypted using attr-encryptted
  def generate_token
    SecureRandom.hex(32)
  end

  # We cannot use a find_by_token_value due to it being encrypted. We need to set a device id to ensure that each user "device" (this can be something like a web browser) has its own id. When subsequent requests for data come in, client needs to send a device id
  def generate_device_id
    SecureRandom.hex(32)
  end
end
