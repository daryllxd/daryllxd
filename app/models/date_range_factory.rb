# frozen_string_literal: true
class DateRangeFactory
  def self.today
    DateRange.new(
      start_date: Date.current,
      end_date: Date.current
    )
  end
end
