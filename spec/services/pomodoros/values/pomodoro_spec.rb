# frozen_string_literal: true

require 'timecop'

RSpec.describe Pomodoros::Values::Pomodoro do
  context 'initializer' do
    context 'happy path' do
      it 'works' do
        new_pomodoro = described_class.new(
          id: 1, description: 'haha', duration: 5, started_at: DateTime.current
        )

        expect(new_pomodoro).to be_valid
      end
    end
  end

  context 'ended_at' do
    it 'adds the duration' do
      Timecop.freeze(2015, 2, 3, 0, 0, 0)  do
        pomo = create(:pv_pomodoro, id: 1, description: 'haha', duration: 5, started_at: DateTime.current)

        expect(pomo.ended_at).to eq(DateTime.new(2015, 2, 3, 0, 5, 0))
      end
    end
  end
end
