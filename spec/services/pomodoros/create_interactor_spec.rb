# frozen_string_literal: true

RSpec.describe Pomodoros::CreateInteractor, type: :service do
  context 'happy path' do
    it 'works if tags are resolved and pomodoros are created' do
      allow(Pomodoros::TagResolver).to receive(:call).and_return(tags: ['mock_found_tag'])
      allow(Pomodoros::CreateService).to receive(:call).and_return(create(:successful_operation))

      expect(Pomodoros::TagResolver).to receive(:call).with(
        tag_string: 'swag'
      )

      expect(Pomodoros::CreateService).to receive(:call).with(
        description: 'hello',
        duration: 5,
        duration_offset: 3,
        tags: ['mock_found_tag']
      )

      result = execute.call(
        description: 'hello',
        duration: '5',
        duration_offset: '3',
        tags: 'swag'
      )

      expect(result).to be_valid
    end
  end

  context 'errors' do
    it 'error in resolving tags: returns an invalid error' do
      allow(Pomodoros::TagResolver).to receive(:call).and_return(create(:daryllxd_error))
      result = execute.call(tags: '')

      expect(result).not_to be_valid
    end

    it 'error in preparing attributes for pomodoro creation: returns an invalid error' do
      allow(Pomodoros::TagResolver).to receive(:call).and_return(create(:successful_operation))

      failure_in_create_service = execute.call(lol: 'pants')

      expect(failure_in_create_service).not_to be_valid
      expect(failure_in_create_service.message).to eq 'Cannot create, invalid pomodoro'
    end

    context 'error in CreateService' do
      it 'results in an error' do
        allow(Pomodoros::TagResolver).to receive(:call).and_return(create(:successful_operation))
        allow(Pomodoros::CreateService).to receive(:call).and_return(create(:daryllxd_error))

        failure_in_create_service = execute.call(tags: 'pants')

        expect(failure_in_create_service).not_to be_valid
        expect(failure_in_create_service.message).to eq 'Cannot create, invalid pomodoro'
      end
    end
  end
end
