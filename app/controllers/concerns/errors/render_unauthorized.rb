# frozen_string_literal: true
module Errors
  module RenderUnauthorized
    extend ActiveSupport::Concern

    def render_unauthorized(message, payload = {})
      unauthorized_error = Errors::Unauthorized.new(
        message: message,
        payload: payload
      )

      render_error_from(unauthorized_error)
    end
  end
end
