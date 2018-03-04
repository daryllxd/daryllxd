# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { error: 'Not authorized', message: error.description } }
  end
end
