# frozen_string_literal: true

module Pomodoros
  module Cli
    RSpec.describe PrepareAttributes do
      context 'happy path' do
        it 'applies transformations for each attribute supplied' do
          create_params = LightService::Context.new(
            params: {
              description: 'Hello',
              duration: '99',
              duration_offset: '98'
            }
          )

          action_result = described_class.execute(create_params)

          expect(action_result.params).to eq(description: 'Hello', duration: 99, duration_offset: 98)
        end

        it 'only applies the transformation to the attributes if they were present' do
          create_params = LightService::Context.new(
            params: {
              duration: '99'
            }
          )

          action_result = described_class.execute(create_params)

          expect(action_result.params).to eq(duration: 99)
        end
      end
    end
  end
end
