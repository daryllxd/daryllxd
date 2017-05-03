module AccessTokens
  class DestroyService
    attr_reader :device_id, :found_token

    def initialize(device_id:)
      @device_id = device_id
    end

    def call
      found_access_token = AccessToken.find_by_device_id(device_id)

      # rubocop:disable GuardClause
      if found_access_token
        found_access_token.destroy
        return true
      else
        raise Errors::InvalidCredentials
      end
      # rubocop:enable GuardClause
    end
  end
end
