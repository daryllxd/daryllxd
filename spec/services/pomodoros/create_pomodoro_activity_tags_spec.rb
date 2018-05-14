# frozen_string_literal: true

RSpec.describe Pomodoros::CreatePomodoroActivityTags, type: :ls_action do
  let!(:pomodoro) { create(:pomodoro) }

  context 'happy path' do
    it 'creates a Pomodoro with a start time adjusted for the duration' do
      programming_activity_tag = create(:activity_tag, :programming)
      daryllxd_activity_tag = create(:activity_tag, :daryllxd)

      action_result = described_class.execute(
        pomodoro: pomodoro, activity_tags: [programming_activity_tag, daryllxd_activity_tag]
      )

      expect(action_result).to be_success

      created_pomodoro = action_result.pomodoro

      expect(created_pomodoro.activity_tags).to match_array(
        [programming_activity_tag, daryllxd_activity_tag]
      )
    end
  end

  context 'failures' do
    it 'rolls back a created Pomodoro, and doesnt create tags' do
      # Failure: Violates unique index by creating a PomodoroActivityTag with
      # the same Pomodoro-ActivityTag combination.
      # Needed to create a TestOrganizer to test rollback functionality.
      class TestOrganizer
        extend LightService::Organizer

        def self.call(params)
          with(
            pomodoro: params[:pomodoro], activity_tags: params[:activity_tags]
          ).reduce(actions)
        end

        def self.actions
          [::Pomodoros::CreatePomodoroActivityTags]
        end
      end

      programming_activity_tag = create(:activity_tag, :programming)

      action_result = TestOrganizer.call(
        pomodoro: pomodoro, activity_tags: [programming_activity_tag, programming_activity_tag]
      )

      expect(action_result).to be_failure
      expect(action_result.pomodoro).not_to be_persisted
      expect(action_result.message.message).to eq('Unable to link Pomodoro to Activity Tags.')
      expect(Pomodoro.count).to eq(0)
      expect(PomodoroActivityTag.count).to eq(0)
    end
  end
end
