# frozen_string_literal: true

require 'timecop'

# Bug on tests, it fails at 11-12pm PHT, this must be some timezone issue, but it works
# on the production environment, so I just timecopped everything.
RSpec.describe Pomodoros::Aggregates::ForDateRange do
  context 'happy path' do
    let!(:programming_activity_tag) { create(:activity_tag, :programming) }
    let!(:daryllxd_activity_tag) { create(:activity_tag, :daryllxd) }

    it 'ensure integrity of conversion' do
      Timecop.freeze(Time.local(2015, 2, 3, 0, 0, 0)) do
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
    end

    it 'performance-3 queries, 1 to get Pomos, 1 for the join table, 1 for ActivityTags' do
      Timecop.freeze(Time.local(2015, 2, 3, 0, 0, 0)) do
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

    it 'sorted by reverse start time' do
      Timecop.freeze(Time.local(2015, 2, 3, 0, 0, 0)) do
        pomo1 = create(:pomodoro, started_at: Time.now - 2.hours)
        pomo2 = create(:pomodoro, started_at: Time.now - 4.hours)
        pomo3 = create(:pomodoro, started_at: Time.now - 1.hours)

        pomodoro_collection = described_class.new.pomodoro_collection

        expect(pomodoro_collection.pomodoros.map(&:id)).to eq([pomo3.id, pomo1.id, pomo2.id])
      end
    end
  end
end
