# frozen_string_literal: true
class ApiController < ApplicationController
  before_action :ensure_access_token_is_valid

  def current_user
    # For development/productivity purposes, you can authenticate yourself by just passing params[:user_id].
    @cached_current_user ||= find_current_user
  end

  def find_current_user
    if Rails.env.development?
      User.find_by_id(params[:user_id])
    else
      AccessToken.compare_tokens(request_details).user
    end
  end

  def ensure_params_are_present(param_sym, param_finder = params)
    raise(Errors::MissingParams, "`#{param_sym}`") unless param_finder[param_sym]
  end

  def render_success(status: 200)
    render json: { success: true }, status: status
  end

  def render_error_if_params_are_not_present(param)
    render json: { error: param }, status: 422
  end

  def render_error(message: 'Error', payload: {}, status: 401)
    payload ||= {}
    render json: { error: message }.merge(payload), status: status
  end

  def render_error_from(daryllxd_error)
    error_hash = {
      message: daryllxd_error.message,
      payload: daryllxd_error.payload,
      status: daryllxd_error.http_error_code
    }.compact

    render_error(error_hash)
  end

  def render_errors_for(active_record_object)
    render json: { errors: active_record_object.errors.full_messages }, status: 422
  end
end
