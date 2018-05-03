# frozen_string_literal: true

module Pomodoros
  class BaseService
    def self.call(params)
      new(params).call
    end

    def initialize(params); end
  end
end
