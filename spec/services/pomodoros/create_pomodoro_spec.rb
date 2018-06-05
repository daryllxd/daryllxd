# frozen_string_literal: true

require 'timecop'

RSpec.describe Pomodoros::CreatePomodoro, type: :ls_action do
  context 'happy path' do
    it 'creates a Pomodoro with a start time adjusted for the duration' do
      Timecop.freeze(Time.new(2018, 2, 15, 5, 0, 0)) do
        create_params = LightService::Context.new(
          pomodoro_params: {
            description: 'Styling and profiling',
            duration: 90,
            duration_offset: 30
          }
        )

        action_result = described_class.execute(params: create_params, activity_tags: 'irrelevant')

        expect(action_result).to be_success

        created_pomodoro = action_result.pomodoro

        expect(created_pomodoro.description).to eq('Styling and profiling')
        expect(created_pomodoro.duration).to eq(90)
        expect(created_pomodoro.started_at).to eq(Time.new(2018, 2, 15, 3, 0, 0))
      end
    end
  end

  context 'failures' do
    it 'does not create a Pomodoro, and fails the context' do
      create_params = LightService::Context.new(
        pomodoro_params: {
          description: 'Styling and profiling',
          duration: -90
        }
      )

      action_result = described_class.execute(params: create_params, activity_tags: 'irrelevant')

      expect(action_result).to be_failure
      expect(action_result.message.payload).to match_array(
        ['Duration must be greater than or equal to 0']
      )
    end
  end
end
