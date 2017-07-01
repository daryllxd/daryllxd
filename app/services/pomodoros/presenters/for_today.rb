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
          headings: ['Task', 'Number of Minutes']
        }
      end

      def presented_pomodoros
        pomodoros.map do |pomodoro|
          [pomodoro.description, pomodoro.duration]
        end
      end

      def total_time_for_today
        ['Total time for today:', presented_pomodoros.sum(&:second)]
      end
    end
  end
end
