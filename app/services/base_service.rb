# frozen_string_literal: true

class BaseService
  def self.call(params = nil)
    if params.present?
      new(params).call
    else
      new.call
    end
  end
end
