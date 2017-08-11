# frozen_string_literal: true
module ControllerAuthentication
  extend ActiveSupport::Concern

  def request_details
    @request_details || {
      token_value: request.headers['AccessToken'] || params[:token_value],
      device_id: request.headers['DeviceId'] || params[:device_id],
      user_id: request.headers['UserId'] || params[:user_id]
    }
  end

  def ensure_access_token_is_valid
    render json: { error: 'Invalid credentials' }, status: :unauthorized unless valid_token?
  end

  def valid_token?
    Rails.env.development? || AccessToken.compare_tokens(request_details)
  end

  def deny_access
    render json: { error: 'Invalid credentials' }, status: :unauthorized
  end

  included do
  end
end
