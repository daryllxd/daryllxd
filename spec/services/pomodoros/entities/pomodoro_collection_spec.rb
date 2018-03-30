# frozen_string_literal: true

RSpec.describe Pomodoros::Entities::PomodoroCollection do
  context '#enumerable' do
    it 'iterates over the pomodoros inside' do
      pomo1 = create(:pe_pomodoro, description: 'Pants')
      pomo_collection = described_class.new(pomodoros: [pomo1])

      expect(pomo_collection.map(&:description)).to match_array(['Pants'])
    end
  end

  context '#duration_for and #duration_in_hours' do
    context 'happy path' do
      context 'no argument passed' do
        context 'contains pomodoros' do
          it 'adds up the durations of all its constituent pomos' do
            pomo1 = create(:pe_pomodoro, :programming, duration: 3)
            pomo2 = create(:pe_pomodoro, :writing, duration: 9)

            pomo_collection = described_class.new(pomodoros: [pomo1, pomo2])

            expect(pomo_collection.duration_for).to eq 12
            expect(pomo_collection.duration_in_hours).to eq 0.2
          end
        end

        context 'empty' do
          it 'duration should equal 0' do
            empty_pomo_collection = create(:pe_pomodoro_collection)

            expect(empty_pomo_collection.duration_for).to eq 0
            expect(empty_pomo_collection.duration_in_hours).to eq 0
          end
        end
      end

      it 'should get durations of the tags that were passed in, and for '\
        'duration_in_hours, rounds to the seconde decimal place' do
        pomo_collection = create(
          :pe_pomodoro_collection, pomodoros: [
            create(:pe_pomodoro, :programming, duration: 30),
            create(:pe_pomodoro, :programming, duration: 30),
            create(:pe_pomodoro, :writing, duration: 40)
          ]
        )

        expect(pomo_collection.duration_for('Programming')).to eq(60)
        expect(pomo_collection.duration_in_hours('Programming')).to eq(1)

        expect(pomo_collection.duration_for('Writing')).to eq(40)
        expect(pomo_collection.duration_in_hours('Writing')).to eq(0.67)
        expect(pomo_collection.duration_for('Swagging')).to eq(0)
      end
    end

    context 'empty' do
      it 'duration should equal 0' do
        pomo_collection = create(:pe_pomodoro_collection, pomodoros: [])

        expect(pomo_collection.duration_for('Programming')).to eq(0)
        expect(pomo_collection.duration_for(nil)).to eq(0)
      end
    end
  end
end
