RSpec.describe Pomodoros::ChangeDurationService, type: :service do
  context 'happy path' do
    let!(:pomodoro) do
      create(:pomodoro, duration: 25)
    end

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
end
