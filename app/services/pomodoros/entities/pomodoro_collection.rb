# frozen_string_literal: true

module Pomodoros
  module Entities
    class PomodoroCollection < Dry::Struct
      include Enumerable

      attribute :pomodoros, Types::Strict::Array.of(Pomodoros::Entities::Pomodoro)

      def duration
        sum(&:duration)
      end

      def duration_for(tag_name)
        select { |p| p.contains_tag?(tag_name) }
          .sum(&:duration)
      end

      # Enumerable implementation: interate over pomos
      def each
        pomodoros.each do |pomo|
          yield pomo
        end
      end
    end
  end
end
