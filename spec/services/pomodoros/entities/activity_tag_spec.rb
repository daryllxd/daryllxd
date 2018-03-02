# frozen_string_literal: true

RSpec.describe Pomodoros::Entities::ActivityTag do
  context 'initializer' do
    context 'happy path' do
      it 'works' do
        new_activity_tag = create(:pe_activity_tag, :programming)

        expect(new_activity_tag).to be_a_kind_of(Pomodoros::Entities::ActivityTag)
      end
    end
  end
end
