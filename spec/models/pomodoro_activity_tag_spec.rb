# frozen_string_literal: true

RSpec.describe PomodoroActivityTag, type: :model do
  context 'associations' do
    it { should belong_to(:pomodoro).with_foreign_key(:pomodoro_id) }
    it { should belong_to(:activity_tag).with_foreign_key(:activity_tag_id) }
  end

  context 'validations' do
    it 'validates uniqueness of Pomodoro, scoped to Activity Tag' do
      pomodoro = create(:pomodoro)
      activity_tag = create(:activity_tag, :programming)

      first = create(:pomodoro_activity_tag, pomodoro: pomodoro, activity_tag: activity_tag)

      expect(first).to be_valid

      expect do
        create(:pomodoro_activity_tag, pomodoro: pomodoro, activity_tag: activity_tag)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
