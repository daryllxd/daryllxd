# frozen_string_literal: true
module Pomodoros
  class Destroy < BaseService
    def call
      Pomodoro.last.destroy
    end
  end
end
