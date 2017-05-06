require 'rails_helper'

RSpec.describe PomodoroActivityTag, type: :model do
  context 'associations' do
    it { should belong_to(:pomodoro) }
    it { should belong_to(:activity_tag) }
  end
end
