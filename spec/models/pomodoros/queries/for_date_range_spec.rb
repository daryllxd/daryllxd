# frozen_string_literal: true

RSpec.describe Pomodoros::Queries::ForDateRange, type: :query do
  context 'Pomos found' do
    let!(:created_yesterday) { create(:pomodoro, created_at: Time.zone.now - 1.day) }
    let!(:created_today) { create(:pomodoro, created_at: Time.zone.now) }
    let!(:found_pomodoros) { execute.call }

    it 'gets everything inside the DateRange' do
      expect(found_pomodoros).to match_array([created_today])
    end

    it 'applies a created_at timezone to be in the Pomodoro Timezone' do
      expect(found_pomodoros.to_sql).to include Pomodoros::Constants::TIMEZONE_BASIS
    end

    it 'loads activity tags' do
      expect(found_pomodoros.first.activity_tags).to be_loaded
    end
  end
end
