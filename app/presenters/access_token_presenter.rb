# frozen_string_literal: true
class AccessTokenPresenter < BasePresenter
  def present
    {
      token_value: token_value,
      device_id: device_id
    }
  end
end
