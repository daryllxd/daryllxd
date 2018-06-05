# frozen_string_literal: true

module Pomodoros
  module Cli
    RSpec.describe CreateOrganizer, type: :ls_organizer do
      context 'happy path' do
        let!(:activity_tag) { create(:activity_tag, :programming) }
        let!(:create_params) do
          {
            description: 'Coded something.',
            duration: '9',
            activity_tags: 'p'
          }
        end

        it 'is successful' do
          created_pomodoro = described_class.call(create_params)

          expect(created_pomodoro).to be_success
        end

        it 'calls a series of actions' do
          actions = [
            ::Pomodoros::Cli::ValidateCliParams,
            ::Pomodoros::Cli::ResolveActivityTagsFromTagString,
            ::Pomodoros::CreatePomodoro,
            ::Pomodoros::CreatePomodoroActivityTags
          ]

          ctx = LightService::Context.new(params: create_params)

          actions.each do |action|
            expect(action).to receive(:execute).with(params: ctx).and_return(params: ctx)
          end

          described_class.call(ctx)
        end
      end

      context 'failures' do
        it 'example failure-it returns a failure and has a message with a DaryllxdError' do
          result = described_class.call(nil)

          expect(result).to be_failure
          expect(result.message).to be_a_kind_of(DaryllxdError)
        end
      end
    end
  end
end
