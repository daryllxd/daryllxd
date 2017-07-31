# frozen_string_literal: true
RSpec.describe Pomodoros::CreateService do
  context 'happy path' do
    let!(:programming_activity_tag) { create(:activity_tag, :programming) }
    let!(:daryllxd_activity_tag) { create(:activity_tag, :daryllxd) }

    let!(:created_pomodoro) do
      described_class.new(
        duration: 25,
        description: 'Did things',
        tags: [programming_activity_tag, daryllxd_activity_tag]
      ).call
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
end
