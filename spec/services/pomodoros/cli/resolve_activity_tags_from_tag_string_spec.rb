# frozen_string_literal: true

module Pomodoros
  module Cli
    RSpec.describe ResolveActivityTagsFromTagString, type: :ls_action do
      context 'happy path' do
        let!(:programming_activity_tag) { create(:activity_tag, :programming) }
        let!(:daryllxd_activity_tag) { create(:activity_tag, :daryllxd) }

        it 'given a string, it resolves tags' do
          create_params = LightService::Context.new(
            params: { activity_tags: 'pd' }
          )

          action_result = described_class.execute(create_params)

          expect(action_result).to be_success
          expect(action_result.activity_tags).to match_array(
            [programming_activity_tag, daryllxd_activity_tag]
          )
        end
      end

      context 'errors' do
        context 'mix of find and didnt find' do
          let!(:programming_activity_tag) { create(:activity_tag, :programming) }

          it 'only returns what was found' do
            create_params = LightService::Context.new(params: { activity_tags: 'pd' })
            action_result = described_class.execute(create_params)

            expect(action_result).to be_success
            expect(action_result.activity_tags).to match_array(
              [programming_activity_tag]
            )
          end
        end

        context 'unable to find tag' do
          it 'returns an empty array' do
            create_params = LightService::Context.new(params: { activity_tags: 'abc' })
            action_result = described_class.execute(create_params)

            expect(action_result).to be_failure
          end
        end
      end
    end
  end
end
