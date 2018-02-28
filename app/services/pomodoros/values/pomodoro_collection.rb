# frozen_string_literal: true

module Pomodoros
  module Values
    class PomodoroCollection < Dry::Struct
      attribute :pomodoros, Types::Strict::Array.of(Pomodoros::Values::Pomodoro)

      def duration
        pomodoros.sum(&:duration)
      end
    end
  end
end
