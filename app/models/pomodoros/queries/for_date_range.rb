# frozen_string_literal: true

module Pomodoros
  module Queries
    class ForDateRange
      attr_reader :date_range

      def initialize(date_range: DateRangeFactory.today)
        @date_range = date_range
      end

      def call
        Pomodoro
          .includes(:activity_tags)
          .where('pomodoros.created_at::timestamp WITH TIME ZONE '\
                 "AT TIME ZONE '#{Pomodoros::Constants::TIMEZONE_BASIS}'"\
                 "BETWEEN '#{date_range.start_date.beginning_of_day}' "\
                 "AND '#{date_range.end_date.end_of_day}'")
          .order('id DESC')
      end
    end
  end
end
