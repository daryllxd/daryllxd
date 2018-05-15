# frozen_string_literal: true

module Pomodoros
  module Cli
    RSpec.describe ValidateCliParams, type: :ls_action do
      context 'happy path' do
        it 'is successful' do
          create_params = LightService::Context.new(
            params: {
              description: 'Coded something.',
              duration: 9,
              activity_tags: 'haha'
            }
          )

          action_result = described_class.execute(create_params)

          expect(action_result).to be_success
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
              duration_offset: -3
            }
          )

          action_result = described_class.execute(create_params)

          expect(action_result).to be_failure
          expect(action_result.message.payload).to eq(
            description: ['is missing'], duration: ['is missing'],
            activity_tags: ['is missing'], duration_offset: ['must be greater than 0']
          )
        end
      end
    end
  end
end
