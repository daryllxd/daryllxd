# frozen_string_literal: true

module Cli
  class DateRangeResolver
    attr_reader :date_range_string

    def initialize(date_range_string:)
      @date_range_string = date_range_string
    end

    def call
      mapping_hash[date_range_string] || DateRangeFactory.today
    end

    def mapping_hash
      {
        'y' => DateRangeFactory.yesterday,
        'w' => DateRangeFactory.for_this_week,
        'lw' => DateRangeFactory.for_last_week,
        'm' => DateRangeFactory.for_this_month,
        'lm' => DateRangeFactory.for_last_month,
        'ye' => DateRangeFactory.for_this_year,
        'a' => DateRangeFactory.all_time
      }
    end
  end
end
