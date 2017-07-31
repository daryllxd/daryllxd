# frozen_string_literal: true
require 'terminal-table'

module Pomodoros
  module Presenters
    class ForToday
      attr_reader :pomodoros

      def initialize(pomodoros: Pomodoro.for_date)
        @pomodoros = pomodoros
      end

      def present
        table = Terminal::Table.new(terminal_table_params) do |t|
          t.rows = presented_pomodoros
        end

        table << :separator
        table << total_time_for_today

        table
      end

      private

      def terminal_table_params
        {
          title: "Today's Pomodoros",
          headings: %w(Task Minutes Tags)
        }
      end

      def presented_pomodoros
        pomodoros.map do |pomodoro|
          [pomodoro.description, pomodoro.duration, sorted_tags_for(pomodoro)]
        end
      end

      def total_time_for_today
        ['Total time for today:', presented_pomodoros.sum(&:second), '']
      end

      def sorted_tags_for(pomodoro)
        pomodoro.activity_tags.map(&:name).sort.join(', ')
      end
    end
  end
end
