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
end
