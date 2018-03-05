# frozen_string_literal: true

module Users
  class CreateService
    attr_reader :email, :password

    def initialize(**new_user_attributes)
      @email = new_user_attributes.fetch(:email)
      @password = new_user_attributes.fetch(:password)
    end

    def call
      new_user = User.create(
        email: email,
        password: password
      )

      if new_user.valid?
        SuccessfulOperation.new(payload: new_user)
      else
        DaryllxdError.new(message: new_user.to_error_message_string, payload: new_user)
      end
    end
  end
end
