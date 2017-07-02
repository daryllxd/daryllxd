# frozen_string_literal: true

RSpec.describe Pomodoro, type: :model do
  context 'validations' do
    it { should validate_presence_of(:description) }

    it { should validate_presence_of(:duration) }
    it { should validate_numericality_of(:duration).is_greater_than_or_equal_to(0) }
  end

  context 'associations' do
    it { should have_many(:pomodoro_activity_tags) }
    it { should have_many(:activity_tags).through(:pomodoro_activity_tags) }
  end
end
