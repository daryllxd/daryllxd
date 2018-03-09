# frozen_string_literal: true

require 'terminal-table'

module Pomodoros
  module Presenters
    class ActivityTagBreakdown
      attr_reader :pomodoros

      def initialize(
        date_range: DateRangeFactory.today,
        pomodoros: Pomodoros::Aggregates::ForDateRange.new(date_range: date_range).pomodoro_collection
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
          title: 'Time Spent by Activity Tag',
          headings: headings,
          rows: presented_pomodoros + [:separator] + [total_time_for_date_range]
        ).present
      end

      def headings
        ['Category', 'Minutes Spent', 'Hours Spent']
      end

      def categories
        [
          'Programming',
          'Writing',
          'Self-Improvement',
          'Vlog/Travel',
          'Cooking',
          'Nutrition'
        ]
      end

      def presented_pomodoros
        categories
          .map { |category| ActivityTagRow.new(category, pomodoros) }
          .select { |category| category.duration_for.positive? }
          .sort_by { |category| -category.duration_for }
          .map(&:present)
      end

      def total_time_for_date_range
        ['Total time:', pomodoros.duration, '']
      end
    end

    class ActivityTagRow
      attr_reader :category, :pomodoros

      def initialize(category, pomodoros)
        @category = category
        @pomodoros = pomodoros
      end

      def duration_for
        pomodoros.duration_for(category)
      end

      def duration_for_in_hours
        (duration_for / 60.0).round(2)
      end

      def present
        [
          category, duration_for, duration_for_in_hours
        ]
      end
    end
  end
end
