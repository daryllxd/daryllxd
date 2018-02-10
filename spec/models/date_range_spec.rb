# frozen_string_literal: true

RSpec.describe DateRange, type: :value do
  context 'one_day?' do
    it 'same date: true' do
      same_date = described_class.new(
        start_date: Date.current,
        end_date: Date.current
      )

      expect(same_date.one_day?).to be_truthy
    end

    it 'different_date: false' do
      different_date = described_class.new(
        start_date: Date.current,
        end_date: Date.current + 1.day
      )

      expect(different_date.one_day?).to be_falsey
    end
  end
end
