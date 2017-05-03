RSpec.describe Pomodoros::CreateService do
  context 'happy path' do
    let!(:created_pomodoro) do
      described_class.new(
        duration: 25,
        description: 'Did things'
      ).call
    end

    it 'creates a pomodoro' do
      expect(Pomodoro.count).to eq 1
    end
  end
end

