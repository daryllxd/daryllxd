# frozen_string_literal: true

RSpec.describe Pomodoros::CreateInteractor, type: :service do
  context 'happy path' do
    it 'works if tags are resolved and pomodoros are created' do
      mock_found_tags = create(:successful_operation)
      allow(Pomodoros::TagResolver).to receive(:call).and_return(mock_found_tags)
      allow(Pomodoros::Create).to receive(:call).and_return(create(:successful_operation))

      expect(Pomodoros::TagResolver).to receive(:call).with(
        tag_string: 'swag'
      )

      expect(Pomodoros::Create).to receive(:call).with(
        description: 'hello',
        duration: 5,
        duration_offset: 3,
        tags: mock_found_tags
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
    it 'error in preparing attributes for pomodoro creation: returns an invalid error' do
      failure_in_create_service = execute.call(wrong_parameter: 'pants')

      expect(failure_in_create_service).not_to be_valid
      expect(failure_in_create_service.message).to include('Invalid pomodoro', 'wrong_parameter')
    end

    it 'error in resolving tags: returns an invalid error' do
      allow(Pomodoros::TagResolver).to receive(:call).and_return(create(:daryllxd_error))
      result = execute.call(tags: '')

      expect(result).not_to be_valid
    end

    context 'error in CreateService' do
      it 'results in an error' do
        allow(Pomodoros::TagResolver).to receive(:call).and_return(create(:successful_operation))
        allow(Pomodoros::Create).to receive(:call).and_return(create(:daryllxd_error))

        failure_in_create_service = execute.call(tags: 'pants')

        expect(failure_in_create_service).not_to be_valid
        expect(failure_in_create_service.message).to eq 'Cannot create, invalid pomodoro'
      end
    end
  end
end
