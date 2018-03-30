# frozen_string_literal: true

RSpec.describe DateRangeFactory do
  context '.today' do
    it 'returns a DateRange object with start_date and end_date as the current date' do
      date_range = described_class.today

      expect(date_range).to be_a_kind_of(DateRange)
      expect(date_range.start_date).to eq Date.current
      expect(date_range.end_date).to eq Date.current
    end
  end

  context '.yesterday' do
    it 'returns a DateRange today with start_date yesterday and end_date yesterday' do
      date_range = described_class.yesterday

      expect(date_range.start_date).to eq Date.current.yesterday
      expect(date_range.end_date).to eq Date.current.yesterday
    end
  end

  context '.for_this_week' do
    it 'returns a DateRange with start_date for the start of this week and end_date the current date' do
      date_range = described_class.for_this_week

      expect(date_range.start_date).to eq Date.current.beginning_of_week
      expect(date_range.end_date).to eq Date.current
    end
  end

  context '.for_last_week' do
    it 'returns a DateRange with start_date for the start of last week and end_date the end of last week' do
      date_range = described_class.for_last_week

      expect(date_range.start_date).to eq((Date.current - 1.week).beginning_of_week)
      expect(date_range.end_date).to eq((Date.current - 1.week).end_of_week)
    end
  end

  context '.for_this_year' do
    it 'returns a DateRange with start_date for the start of last week and end_date the end of last week' do
      date_range = described_class.for_this_year

      expect(date_range.start_date).to eq(Date.current.beginning_of_year)
      expect(date_range.end_date).to eq(Date.current)
    end
  end
end
