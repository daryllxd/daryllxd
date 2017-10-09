# frozen_string_literal: true

RSpec.describe Expenses::Queries::ForDateRange, type: :query do
  context 'Expenses created' do
    let!(:created_yesterday) { create(:expense, created_at: Time.zone.now - 1.day) }
    let!(:created_today) { create(:expense, created_at: Time.zone.now) }
    let!(:found_expenses) { execute.call }

    it 'gets everything inside the DateRange' do
      expect(found_expenses).to match_array([created_today])
    end

    it 'applies a created_at timezone to be in the expense Timezone' do
      expect(found_expenses.to_sql).to include Constants::TIMEZONE_BASIS
    end

    it 'loads activity tags' do
      expect(found_expenses.first.budget_tags).to be_loaded
    end
  end
end
