# frozen_string_literal: true

class SuccessfulOperation
  attr_reader :payload

  def initialize(payload: nil)
    @payload = payload
  end

  def valid?
    true
  end
end
