require 'rails_helper'

RSpec.describe ActivityTag, type: :model do
  context 'validations' do
    context 'name' do
      it { should validate_presence_of(:name) }

      it 'validates the uniqueness of name' do
        _existing_tag = create(:activity_tag, name: 'Gallivanting')
        new_tag = build(:activity_tag, name: 'Gallivanting')

        expect(new_tag).not_to be_valid
      end
    end
  end

  context 'associations' do
    it { should have_many(:pomodoro_activity_tags) }
    it { should have_many(:pomodoros).through(:pomodoro_activity_tags) }
  end
end
