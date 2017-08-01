# frozen_string_literal: true
RSpec.describe DateRangeFactory do
  context '.today' do
    it 'returns a DateRange object with start_date and end_date as the current date' do
      date_range_today = described_class.today

      expect(date_range_today).to be_a_kind_of(DateRange)
      expect(date_range_today.start_date).to eq Date.current
      expect(date_range_today.end_date).to eq Date.current
    end
  end
end
