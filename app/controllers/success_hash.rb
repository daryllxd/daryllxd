# frozen_string_literal: true

# Abstracts appending payloads to a "success" HTTP response.
# The common HTTP response would be { success: true }, but
# if helpful data needs to be appended, the SuccessHash
# can handle it.
class SuccessHash
  attr_reader :payload

  def initialize(payload: nil)
    @payload = payload
  end

  def render
    success_hash
  end

  private

  def success_hash
    if payload
      base_success_hash.merge(data: payload)
    else
      base_success_hash
    end
  end

  def base_success_hash
    { success: true }
  end
end
