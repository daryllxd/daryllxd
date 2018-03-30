# frozen_string_literal: true

class DateRangeFactory
  def self.today
    DateRange.new(
      start_date: Date.current,
      end_date: Date.current
    )
  end

  def self.yesterday
    DateRange.new(
      start_date: Date.current.yesterday,
      end_date: Date.current.yesterday
    )
  end

  def self.for_this_week
    DateRange.new(
      start_date: Date.current.beginning_of_week,
      end_date: Date.current
    )
  end

  def self.for_last_week
    DateRange.new(
      start_date: (Date.current - 1.week).beginning_of_week,
      end_date: (Date.current - 1.week).end_of_week
    )
  end

  def self.for_this_month
    DateRange.new(
      start_date: Date.current.beginning_of_month,
      end_date: Date.current
    )
  end

  def self.for_last_month
    DateRange.new(
      start_date: (Date.current - 1.month).beginning_of_month,
      end_date: (Date.current - 1.month).end_of_month
    )
  end

  def self.for_this_year
    DateRange.new(
      start_date: Date.current.beginning_of_year,
      end_date: Date.current
    )
  end

  def self.all_time
    DateRange.new(
      start_date: (Date.current - 10.years).beginning_of_week,
      end_date: (Date.current - 1.week).end_of_week
    )
  end
end
