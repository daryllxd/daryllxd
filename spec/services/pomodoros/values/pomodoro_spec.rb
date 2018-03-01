# frozen_string_literal: true

require 'timecop'

RSpec.describe Pomodoros::Values::Pomodoro do
  context 'initializer' do
    context 'happy path' do
      it 'works, and activity tags are empty' do
        new_pomodoro = described_class.new(
          id: 1, description: 'haha', duration: 5, started_at: Time.current
        )

        expect(new_pomodoro).to be_a_kind_of(Pomodoros::Values::Pomodoro)
        expect(new_pomodoro.activity_tags).to be_empty
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

  context '#contains_tag?' do
    it 'expects a string match on the tag to be true' do
      pomodoro = create(
        :pv_pomodoro, activity_tags: [
          create(:pv_activity_tag, :programming)
        ]
      )

      expect(pomodoro.contains_tag?('Programming')).to be_truthy
      expect(pomodoro.contains_tag?('Swagging')).to be_falsey
      expect(pomodoro.contains_tag?(:programming)).to be_falsey
    end
  end
end
