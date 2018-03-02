# frozen_string_literal: true

RSpec.describe Pomodoros::Entities::PomodoroCollection do
  context '#enumerable' do
    it 'iterates over the pomodoros inside' do
      pomo1 = create(:pe_pomodoro, description: 'Pants')
      pomo_collection = described_class.new(pomodoros: [pomo1])

      expect(pomo_collection.map(&:description)).to match_array(['Pants'])
    end
  end

  context '#duration' do
    context 'contains pomodoros' do
      it 'adds up the durations of all its constituent pomos' do
        pomo1 = create(:pe_pomodoro, duration: 3)
        pomo2 = create(:pe_pomodoro, duration: 9)

        pomo_collection = described_class.new(pomodoros: [pomo1, pomo2])

        expect(pomo_collection.duration).to eq 12
      end
    end

    context 'empty' do
      it 'duration should equal 0' do
        empty_pomo_collection = create(:pe_pomodoro_collection)

        expect(empty_pomo_collection.duration).to eq 0
      end
    end
  end

  context '#duration_for' do
    context 'happy path' do
      it 'should get durations of the tags that were passed in' do
        pomo_collection = create(
          :pe_pomodoro_collection, pomodoros: [
            create(:pe_pomodoro, :programming, duration: 20),
            create(:pe_pomodoro, :programming, duration: 30),
            create(:pe_pomodoro, :writing, duration: 40)
          ]
        )

        expect(pomo_collection.duration_for('Programming')).to eq(50)
        expect(pomo_collection.duration_for('Writing')).to eq(40)
        expect(pomo_collection.duration_for('Swagging')).to eq(0)
        expect(pomo_collection.duration_for(nil)).to eq(0)
      end
    end

    context 'no pomodoros' do
      it 'works' do
        pomo_collection = create(:pe_pomodoro_collection, pomodoros: [])

        expect(pomo_collection.duration_for('Programming')).to eq(0)
        expect(pomo_collection.duration_for(nil)).to eq(0)
      end
    end
  end
end
