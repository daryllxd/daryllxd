# frozen_string_literal: true
module Pomodoros
  class DestroyService
    def call
      Pomodoro.last.destroy
    end
  end
end
