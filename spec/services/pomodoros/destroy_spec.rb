# frozen_string_literal: true

RSpec.describe Pomodoros::Destroy, type: :service do
  context '#call' do
    context 'success' do
      it 'it destroys the last Pomodoro and its activity tags' do
        _pomo1 = create(:pomodoro)
        pomo2 = create(:pomodoro)

        activity_tag = create(:activity_tag, :programming)
        create(:pomodoro_activity_tag, pomodoro: pomo2, activity_tag: activity_tag)

        execute.call
        expect(Pomodoro.find_by(id: pomo2.id)).to be_nil
        expect(PomodoroActivityTag.find_by(activity_tag_id: activity_tag.id)).to be_nil
      end
    end
  end
end
