# frozen_string_literal: true

module Pomodoros
  module Entities
    class PomodoroCollection < Dry::Struct
      attribute :pomodoros, Types::Strict::Array.of(Pomodoros::Entities::Pomodoro)

      def duration
        pomodoros.sum(&:duration)
      end

      def duration_for(tag_name)
        pomodoros
          .select { |p| p.contains_tag?(tag_name) }
          .sum(&:duration)
      end
    end
  end
end