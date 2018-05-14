# frozen_string_literal: true

RSpec.describe Pomodoros::Web::ValidateWebParams, type: :service do
  context 'happy path' do
    it 'is successful' do
      pomodoro_create_params = {
        pomodoro: {
          description: 'Coded something.', duration: 9, started_at: Time.current
        },
        activity_tags: [
          { id: 1, description: 'Swagging' },
          { id: 2, description: 'Campaigning' }
        ]
      }

      expect(execute.call(pomodoro_create_params)).to be_valid
    end
  end

  context 'errors' do
    it 'generic error/nils' do
      operation_result = execute.call(nil)

      expect(operation_result).not_to be_valid
      expect(operation_result.payload).to eq(
        pomodoro: ['is missing'],
        activity_tags: ['is missing']
      )
    end

    it 'error in pomodoro schema' do
      operation_result = execute.call(
        pomodoro: {},
        activity_tags: [{ id: 1, description: 'Coding' }]
      )

      expect(operation_result).not_to be_valid
      expect(operation_result.payload).to eq(
        pomodoro: { description: ['is missing'], duration: ['is missing'], started_at: ['is missing'] }
      )
    end

    it 'error in activity_tag schema' do
      operation_result = execute.call(
        pomodoro: { description: 'Hello', duration: 5, started_at: Time.current },
        activity_tags: [{ irrelevant: 'irrelevant' }]
      )

      expect(operation_result).not_to be_valid
      expect(operation_result.payload).to eq(
        activity_tags: { 0 => { id: ['is missing'], description: ['is missing'] } }
      )
    end
  end
end
