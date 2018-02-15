# frozen_string_literal: true
require 'terminal-table'

module Pomodoros
  module Presenters
    class ForDateRange
      attr_reader :pomodoros

      def initialize(
        date_range: DateRangeFactory.today,
        pomodoros: Pomodoros::Queries::ForDateRange.new(date_range: date_range).call
      )
        @pomodoros = pomodoros
      end

      def present
        [
          total_time_table
        ]
      end

      private

      def total_time_table
        Pomodoros::Presenters::TerminalTable.new(
          title: "Today's Pomodoros",
          headings: headings,
          rows: presented_pomodoros + [:separator] + [total_time_for_today]
        ).present
      end

      def headings
        ['Task', 'Minutes Spent', 'Tagged as', 'Created at', 'Expected time of start']
      end

      def presented_pomodoros
        pomodoros.map do |pomodoro|
          [pomodoro.description, pomodoro.duration, sorted_tags_for(pomodoro), pomodoro.created_at.localtime,
           pomodoro.created_at.localtime - pomodoro.duration.minutes]
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
