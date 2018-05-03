# frozen_string_literal: true

RSpec.describe Pomodoros::UpdateInteractor, type: :service do
  context 'happy path' do
    it 'works if tags are resolved and pomodoros are created' do
      mock_found_pomodoro = create(:successful_operation)
      mock_found_tags = create(:successful_operation)
      allow(Pomodoro).to receive(:find_by).and_return(mock_found_pomodoro)
      allow(Pomodoros::TagResolver).to receive(:call).and_return(mock_found_tags)
      expect(Pomodoros::TagResolver).to receive(:call).with(
        tag_string: 'swag'
      )
      allow(Pomodoros::Update).to receive(:call).and_return(create(:successful_operation))

      expect(Pomodoros::Update).to receive(:call).with(
        pomodoro: mock_found_pomodoro,
        pomodoro_attributes: {
          description: 'hello',
          duration: 5
        },
        tags: mock_found_tags
      )

      result = execute.call(
        pomodoro_id: 1,
        description: 'hello',
        duration: '5',
        tags: 'swag'
      )

      expect(result).to be_valid
    end
  end

  context 'errors' do
    it 'invalid pomodoro_attributes: returns an Error' do
      result = execute.call(wrong_parameter: 'yes')

      expect(result).not_to be_valid
      expect(result.message).to include('wrong_parameter')
    end

    it 'cannot find Pomodoro: returns an Error' do
      result = execute.call(pomodoro_id: -1)

      expect(result).not_to be_valid
      expect(result.message).to eq(I18n.t('pomodoro.find.error_cannot_find'))
    end

    it 'error when resolving tags: returns an Error' do
      allow(Pomodoro).to receive(:find_by).and_return(create(:successful_operation))
      allow(Pomodoros::TagResolver).to receive(:call).and_return(create(:daryllxd_error, message: 'Mock: Tag error.'))

      result = execute.call(pomodoro_id: 1, tags: 'wrong_tags')

      expect(result).not_to be_valid
      expect(result.message).to eq('Mock: Tag error.')
    end

    context 'error in CreateService' do
      it 'results in an error' do
        allow(Pomodoro).to receive(:find_by).and_return(create(:successful_operation))
        allow(Pomodoros::TagResolver).to receive(:call).and_return(create(:successful_operation))
        allow(Pomodoros::Update).to receive(:call).and_return(
          create(:daryllxd_error, message: 'Mock: Unable to update.')
        )

        failure_in_create_service = execute.call(tags: 'pants')

        expect(failure_in_create_service).not_to be_valid
        expect(failure_in_create_service.message).to eq 'Mock: Unable to update.'
      end
    end
  end
end
