# frozen_string_literal: true

RSpec.describe Pomodoros::Values::PomodoroCollection do
  context '#duration' do
    context 'contains pomodoros' do
      it 'adds up the durations of all its constituent pomos' do
        pomo1 = create(:pv_pomodoro, duration: 3)
        pomo2 = create(:pv_pomodoro, duration: 9)

        pomo_collection = described_class.new(pomodoros: [pomo1, pomo2])

        expect(pomo_collection.duration).to eq 12
      end
    end

    context 'empty' do
      it 'duration should equal 0' do
        empty_pomo_collection = create(:pv_pomodoro_collection)

        expect(empty_pomo_collection.duration).to eq 0
      end
    end
  end
end
