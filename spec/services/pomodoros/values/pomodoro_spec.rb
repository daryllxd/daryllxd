# frozen_string_literal: true

require 'timecop'

RSpec.describe Pomodoros::Values::Pomodoro do
  context 'initializer' do
    context 'happy path' do
      it 'works' do
        new_pomodoro = described_class.new(
          id: 1, description: 'haha', duration: 5, started_at: Time.current
        )

        expect(new_pomodoro).to be_a_kind_of(Pomodoros::Values::Pomodoro)
      end
    end
  end

  context '#ended_at' do
    it 'adds the duration' do
      Timecop.freeze(Time.local(2015, 2, 3, 0, 0, 0)) do
        pomo = create(:pv_pomodoro, id: 1, description: 'haha', duration: 5, started_at: Time.now)

        expect(pomo.ended_at).to eq(Time.new(2015, 2, 3, 0, 5, 0))
      end
    end
  end
end
