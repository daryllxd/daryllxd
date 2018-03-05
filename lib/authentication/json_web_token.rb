# frozen_string_literal: true

module Authentication
  class JsonWebToken
    def self.encode(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def self.decode(token)
      return SuccessfulOperation.new(
        payload: HashWithIndifferentAccess.new(
          JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
        )
      )
    rescue JWT::VerificationError
      DaryllxdError.new('Incorrect JSON Web token.')
    end
  end
end
