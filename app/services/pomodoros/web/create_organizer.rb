# frozen_string_literal: true

module Pomodoros
  module Web
    class CreateOrganizer
      extend LightService::Organizer

      # Expecting a non-hash call from a controller.
      # We raise the params to a hash because we will be creating pomodoros
      # and activity_tags in the context.
      def self.call(params)
        with(params: params).reduce(actions)
      end

      def self.actions
        [
          ::Pomodoros::Web::ValidateWebParams,
          ::Pomodoros::ResolveActivityTagsFromParams,
          ::Pomodoros::CreatePomodoro,
          ::Pomodoros::CreatePomodoroActivityTags
        ]
      end
    end
  end
end
