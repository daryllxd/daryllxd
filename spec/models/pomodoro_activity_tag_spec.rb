# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PomodoroActivityTag, type: :model do
  context 'associations' do
    it { should belong_to(:pomodoro).with_foreign_key(:pomodoro_id) }
    it { should belong_to(:activity_tag).with_foreign_key(:activity_tag_id) }
  end
end
