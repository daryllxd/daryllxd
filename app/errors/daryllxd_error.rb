# frozen_string_literal: true

class DaryllxdError < StandardError
  attr_reader :message, :payload

  def initialize(message: 'Error.', payload: nil)
    @message = message
    @payload = payload
  end

  def valid?
    false
  end

  # TODO: Refactor into a better implementation
  def http_error_code
    400
  end
end
