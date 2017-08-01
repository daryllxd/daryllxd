# frozen_string_literal: true
RSpec.describe Pomodoros::Queries::ForDateRange, type: :query do
  context 'Pomos found' do
    it 'gets everything inside the DateRange' do
      _created_yesterday = create(:pomodoro, created_at: Date.current - 1.day)
      created_today = create(:pomodoro, created_at: Date.current)

      found_pomodoros = execute.call

      expect(found_pomodoros).to match_array([created_today])

      # Expect activity tags to be loaded
      expect(found_pomodoros.first.activity_tags).to be_loaded
    end
  end
end
