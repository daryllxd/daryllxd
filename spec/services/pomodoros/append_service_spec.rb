# frozen_string_literal: true
RSpec.describe Pomodoros::AppendService, type: :service do
  let!(:execute) do
    proc { |params| described_class.new(params).call }
  end

  let!(:created_pomodoro) do
    create(:pomodoro, duration: 25)
  end

  context 'happy path' do
    let!(:appended_pomodoro) do
      execute.call(duration: 25)
    end

    it 'creates a pomodoro' do
      expect(created_pomodoro.reload.duration).to eq 50
    end
  end

  context 'errors' do
    context 'message' do
      let!(:tried_letter) do
        execute.call(duration: 'yolo')
      end

      it 'raises an error' do
        expect(tried_letter).to be_a_kind_of(Pomodoros::Errors::GenericError)
      end
    end
  end
end
