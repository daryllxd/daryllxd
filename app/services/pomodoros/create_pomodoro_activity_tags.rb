# frozen_string_literal: true

module Pomodoros
  class CreatePomodoroActivityTags
    extend LightService::Action

    expects :pomodoro, :activity_tags

    executed do |context|
      created_tags = context.activity_tags.map do |tag|
        context.pomodoro.pomodoro_activity_tags.create(activity_tag: tag)
      end

      context.fail_with_rollback!(error_from(created_tags)) unless created_tags.all?(&:valid?)
    end

    rolled_back do |context|
      context.pomodoro.destroy
    end

    def self.error_from(created_tags)
      DaryllxdError.new(
        message: 'Unable to link Pomodoro to Activity Tags.', payload: created_tags.map(&:errors).map(&:full_messages)
      )
    end
  end
end
