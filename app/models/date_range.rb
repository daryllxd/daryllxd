# frozen_string_literal: true
class DateRange
  attr_reader :start_date, :end_date

  def initialize(start_date:, end_date:)
    @start_date = start_date
    @end_date = end_date
  end

  def one_day?
    (end_date - start_date) < 1
  end
end
