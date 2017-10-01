# frozen_string_literal: true
RSpec.describe Pomodoros::CreateService, type: :service do
  context 'happy path' do
    let!(:programming_activity_tag) { create(:activity_tag, :programming) }
    let!(:daryllxd_activity_tag) { create(:activity_tag, :daryllxd) }

    let!(:created_pomodoro) do
      execute.call(
        duration: 25,
        description: 'Did things',
        tags: [programming_activity_tag, daryllxd_activity_tag]
      )
    end

    it 'creates a pomodoro' do
      expect(Pomodoro.count).to eq 1
    end

    it 'creates a tag' do
      expect(created_pomodoro.activity_tags).to match_array(
        [programming_activity_tag, daryllxd_activity_tag]
      )
    end
  end

  context 'errors' do
    context 'no tags' do
      let!(:created_pomodoro) do
        execute.call(
          duration: 25,
          description: 'Did things',
          tags: []
        )
      end

      it 'returns an error specifying that a tag is needed' do
        expect(Pomodoro.count).to eq 0
        expect(created_pomodoro).not_to be_valid
        expect(created_pomodoro.message).to include('no tags')
      end
    end
  end
end
