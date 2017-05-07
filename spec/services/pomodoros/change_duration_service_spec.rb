RSpec.describe Pomodoros::ChangeDurationService, type: :service do
  let!(:pomodoro) do
    create(:pomodoro, duration: 25)
  end

  context 'happy path' do
    context 'absolute: true' do
      let!(:changed_duration) do
        described_class.new(
          pomodoro: pomodoro,
          duration: 30,
          absolute: true
        ).call
      end

      it 'changes the duration to the one specified in the parameter' do
        expect(pomodoro.reload.duration).to eq 30
      end
    end

    context 'absolute: false' do
      let!(:changed_duration) do
        described_class.new(
          pomodoro: pomodoro,
          duration: -5,
          absolute: false
        ).call
      end

      it 'adds or subtracts based on the duration' do
        expect(pomodoro.reload.duration).to eq 20
      end
    end
  end

  context 'bad path' do
    let!(:changed_duration_error) do
      described_class.new(
        pomodoro: pomodoro,
        duration: 'awtsu',
        absolute: false
      ).call
    end

    it 'raises an error' do
      expect(changed_duration_error).to be_a_kind_of(Pomodoros::Errors::GenericError)
      expect(changed_duration_error).not_to be_valid
    end
  end
end
