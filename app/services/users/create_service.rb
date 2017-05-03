module Users
  class CreateService
    attr_reader :new_user_params, :new_user

    def initialize(new_user_params:)
      @new_user_params = new_user_params
    end

    def call
      @new_user = User.new_with_session(new_user_attributes, 'NECESSARY_PARAMETER')

      if new_user && new_user.save
        new_access_token = AccessTokens::CreateService.new(user: new_user).call

        NewUser.new(access_token: new_access_token, user: new_user)
      else
        # This is an invalid object
        new_user
      end
    end

    def new_user_attributes
      attribute_hash = {}
      allowed_attributes.each do |attr|
        attribute_hash[attr] = new_user_params[attr]
      end
      attribute_hash
    end

    def allowed_attributes
      %i(email first_name handicap_value last_name nickname location ghin password password_confirmation)
    end
  end
end
