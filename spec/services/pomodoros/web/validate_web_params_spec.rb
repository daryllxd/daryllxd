# frozen_string_literal: true

RSpec.describe Pomodoros::Web::ValidateWebParams, type: :ls_action do
  context 'happy path' do
    it 'is successful' do
      create_params = LightService::Context.new(
        pomodoro: {
          description: 'Coded something.', duration: 9, started_at: Time.current
        },
        activity_tags: [
          { id: 1, name: 'Swagging' },
          { id: 2, name: 'Campaigning' }
        ]
      )

      action_result = described_class.execute(params: create_params)

      expect(action_result).to be_success
    end
  end

  context 'errors' do
    it 'generic error/nils' do
      create_params = {}

      action_result = described_class.execute(params: create_params)

      expect(action_result).to be_failure
      expect(action_result.message.payload).to eq(
        pomodoro: ['is missing'],
        activity_tags: ['is missing']
      )
    end

    it 'error in pomodoro schema' do
      create_params = LightService::Context.new(
        pomodoro: {},
        activity_tags: [{ id: 1, name: 'Coding' }]
      )

      action_result = described_class.execute(params: create_params)

      expect(action_result).to be_failure
      expect(action_result.message.payload).to eq(
        pomodoro: { description: ['is missing'], duration: ['is missing'], started_at: ['is missing'] }
      )
    end

    it 'error in activity_tag schema' do
      create_params = LightService::Context.new(
        pomodoro: { description: 'Hello', duration: 5, started_at: Time.current },
        activity_tags: [{ irrelevant: 'irrelevant' }]
      )

      action_result = described_class.execute(params: create_params)

      expect(action_result).to be_failure
      expect(action_result.message.payload).to eq(
        activity_tags: { 0 => { id: ['is missing'], name: ['is missing'] } }
      )
    end
  end
end
