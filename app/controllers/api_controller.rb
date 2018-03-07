# frozen_string_literal: true

class ApiController < ApplicationController
  # Payload must be a hash.
  def render_token_with(user:, payload:)
    jwt = Authentication::JsonWebToken.encode(
      user_email: user.email
    )

    render_success(payload: payload.merge(token: jwt))
  end

  # Payload must be a hash.
  def render_success(payload: nil, status: infer_status_from_action)
    render json: SuccessHash.new(payload: payload).render, status: status
  end

  # Renedering errors
  def render_error(message: 'Error', payload: nil, status: 400)
    render json: ErrorResponse.new(message: message, payload: payload).render, status: status
  end

  def render_error_from(daryllxd_error)
    error_hash = {
      message: daryllxd_error.message,
      payload: daryllxd_error.payload,
      status: daryllxd_error.http_error_code
    }.compact

    render_error(error_hash)
  end

  private

  def infer_status_from_action
    if params[:action] == 'create'
      201
    else
      200
    end
  end
end
