# frozen_string_literal: true

module Cli
  class DateRangeResolver
    attr_reader :date_range_string

    def initialize(date_range_string:)
      @date_range_string = date_range_string
    end

    def call
      case date_range_string
      when 'y' then DateRangeFactory.yesterday
      when 'w' then DateRangeFactory.for_this_week
      when 'lw' then DateRangeFactory.for_last_week
      else DateRangeFactory.today
      end
    end
  end
end
