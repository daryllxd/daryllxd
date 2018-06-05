# frozen_string_literal: true

module Pomodoros
  module Cli
    RSpec.describe ValidateCliParams, type: :ls_action do
      context 'happy path' do
        it 'validates successfully, sanitizes irrelevant parameters, ' \
          'and saves the relevant parameters in a different key' do
          create_params = LightService::Context.new(
            params: {
              description: 'Coded something.',
              duration: '9',
              duration_offset: '3',
              activity_tags: 'haha',
              irrelevant: 'yes'
            }
          )

          action_result = described_class.execute(create_params)

          expect(action_result).to be_success

          expect(action_result.params[:pomodoro_params]).to eq({
            description: 'Coded something.',
            duration: 9,
            duration_offset: 3,
            activity_tags: 'haha'
          })
        end
      end

      context 'errors' do
        it 'generic error' do
          expect do
            described_class.execute({})
          end.to raise_error(LightService::ExpectedKeysNotInContextError)
        end

        it 'error in params' do
          create_params = LightService::Context.new(
            params: {
              duration_offset: -3,
            }
          )

          action_result = described_class.execute(create_params)

          expect(action_result).to be_failure
          expect(action_result.message.payload).to eq(
            description: ['is missing'], duration: ['is missing'],
            activity_tags: ['is missing'], duration_offset: ['must be greater than or equal to 0']
          )
        end
      end
    end
  end
end
