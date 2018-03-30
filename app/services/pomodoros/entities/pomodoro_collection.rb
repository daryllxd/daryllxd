# frozen_string_literal: true

module Pomodoros
  module Entities
    class PomodoroCollection < Dry::Struct
      include Enumerable

      attribute :pomodoros, Types::Strict::Array.of(Pomodoros::Entities::Pomodoro)

      # If tag is passed, get duration for that tag. If not, get duration for everything
      def duration_for(tag_name = nil)
        block = if tag_name
                  proc { select { |p| p.contains_tag?(tag_name) } }
                else
                  proc { self }
                end

        block
          .call
          .sum(&:duration)
      end

      def duration_in_hours(tag_name = nil)
        (duration_for(tag_name) / 60.0).round(2)
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
