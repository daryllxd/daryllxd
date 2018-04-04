# frozen_string_literal: true

module Pomodoros
  class UpdateService < Pomodoros::BaseService
    include HasSteps
    extend Memoist

    attr_reader :pomodoro, :pomodoro_attributes, :tags, :errors

    # tags: PomodoroActivityTag
    def initialize(pomodoro:, tags: nil, pomodoro_attributes: {})
      @pomodoro = pomodoro
      @tags = tags
      @pomodoro_attributes = pomodoro_attributes
    end

    def steps
      [
        proc { update_pomodoro! },
        proc { update_tags! }
      ]
    end

    def success_return_value
      update_pomodoro!
    end

    private

    def update_pomodoro!
      pomodoro.update_attributes!(update_pomodoro_attributes) if update_pomodoro_attributes.present?
      pomodoro
    end

    def update_pomodoro_attributes
      keys = %i[description duration]

      keys.each_with_object({}) do |key, acc|
        acc[key] = pomodoro_attributes[key] if pomodoro_attributes[key]

        acc
      end
    end

    # This looks really bad. Any way to update this?
    def update_tags!
      if tags.present?
        old_tags = pomodoro.activity_tags

        (tags - old_tags).map do |tag|
          pomodoro.pomodoro_activity_tags.create!(activity_tag: tag)
        end

        pomodoro.pomodoro_activity_tags.where(
          activity_tag_id: (old_tags - tags).pluck(:id)
        ).destroy_all

        pomodoro.activity_tags
      else
        SuccessfulOperation.new
      end
    end

    memoize :update_pomodoro!
  end
end
