# frozen_string_literal: true

class ErrorResponse
  attr_reader :message, :payload

  # Message is required, payload is not.
  def initialize(message:, payload: nil)
    @message = message
    @payload = payload
  end

  def render
    {
      success: false,
      data: { message: message }.merge(payload_response)
    }
  end

  private

  def payload_response
    if payload.present?
      { payload: payload }
    else
      {}
    end
  end
end
