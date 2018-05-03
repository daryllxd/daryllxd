# frozen_string_literal: true

module Pomodoros
  class BaseService
    def self.call(*params)
      new(*params).call
    end
  end
end
