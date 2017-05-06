require 'rails_helper'

RSpec.describe ActivityTag, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
  end

  context 'associations' do
    it { should have_many(:pomodoro_activity_tags) }
    it { should have_many(:pomodoros).through(:pomodoro_activity_tags) }
  end
end
