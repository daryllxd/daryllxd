# frozen_string_literal: true

RSpec.describe Pomodoros::Aggregates::ForDateRange do
  context 'message' do
    let!(:programming_activity_tag) { create(:activity_tag, :programming) }
    let!(:daryllxd_activity_tag) { create(:activity_tag, :daryllxd) }

    it 'ensure integrity of conversion' do
      pomo1 = create(:pomodoro)
      pomo1.create_activity_tag!(programming_activity_tag)
      pomo2 = create(:pomodoro)
      pomo2.create_activity_tag!(daryllxd_activity_tag)

      pomodoro_collection = described_class.new.pomodoro_collection

      expect(pomodoro_collection).to be_a_kind_of(Pomodoros::Entities::PomodoroCollection)
      expect(pomodoro_collection.pomodoros.map(&:id)).to match_array([pomo1.id, pomo2.id])

      pomo1_in_collection = pomodoro_collection.pomodoros.find { |p| p.id == pomo1.id }

      expect(pomo1_in_collection.activity_tags.map(&:name)).to match_array('Programming')
    end

    it 'performance-3 queries, 1 to get Pomos, 1 for the join table, 1 for ActivityTags' do
      pomo1 = create(:pomodoro)
      pomo1.create_activity_tag!(programming_activity_tag)
      pomo2 = create(:pomodoro)
      pomo2.create_activity_tag!(daryllxd_activity_tag)

      aggregate = described_class.new

      query_test = -> { aggregate.pomodoro_collection }

      # Ensure that aggregate.pomodoro_collection is also memoized
      expect { 2.times { query_test.call } }.to make_database_queries(count: 3)
    end
  end
end
