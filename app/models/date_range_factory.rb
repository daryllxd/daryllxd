# frozen_string_literal: true
class DateRangeFactory
  def self.today
    Time.zone = 'America/New_York'
    DateRange.new(
      start_date: Date.current,
      end_date: Date.current
    )
  end

  def self.yesterday
    DateRange.new(
      start_date: Date.current - 1.day,
      end_date: Date.current - 1.day
    )
  end
end
