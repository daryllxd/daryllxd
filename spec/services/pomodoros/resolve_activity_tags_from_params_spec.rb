# frozen_string_literal: true

RSpec.describe Pomodoros::ResolveActivityTagsFromParams, type: :ls_action do
  context 'happy path' do
    it 'finds activity tags and adds `activity_tags` to the context' do
      programming_activity_tag = create(:activity_tag, :programming)
      daryllxd_activity_tag = create(:activity_tag, :daryllxd)

      create_params = LightService::Context.new(
        activity_tags: [
          { id: programming_activity_tag.id, description: 'irrelevant' },
          { id: daryllxd_activity_tag.id, description: 'irrelevant' }
        ]
      )

      action_result = described_class.execute(params: create_params)

      expect(action_result).to be_success
      expect(action_result.activity_tags).to match_array([programming_activity_tag, daryllxd_activity_tag])
    end
  end

  context 'errors' do
    it 'if an activity tag cannot be found for an ID, fail the action, ' \
      'even if tags have been fetched for the other IDs' do
      activity_tag = create(:activity_tag, :programming)

      create_params = LightService::Context.new(
        activity_tags: [
          { id: activity_tag.id, name: activity_tag.name },
          { id: -99, name: 'huhu' }
        ]
      )

      action_result = described_class.execute(params: create_params)

      expect(action_result).to be_failure
      expect(action_result.message.payload).to eq(
        activity_tag_ids: [-99]
      )
    end
  end
end
