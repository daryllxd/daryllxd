# frozen_string_literal: true

module Pomodoros
  module Cli
    class CreateOrganizer
      extend LightService::Organizer

      def self.call(params)
        with(params: params).reduce(actions)
      end

      def self.actions
        [
          ::Pomodoros::Cli::PrepareAttributes,
          ::Pomodoros::Cli::ValidateCliParams,
          ::Pomodoros::Cli::ResolveActivityTagsFromTagString,
          ::Pomodoros::CreatePomodoro,
          ::Pomodoros::CreatePomodoroActivityTags
        ]
      end
    end
  end
end
