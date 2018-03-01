# frozen_string_literal: true

RSpec.describe Pomodoros::Values::ActivityTag do
  context 'initializer' do
    context 'happy path' do
      it 'works' do
        new_activity_tag = create(:pv_activity_tag, :programming)

        expect(new_activity_tag).to be_a_kind_of(Pomodoros::Values::ActivityTag)
      end
    end
  end
end
