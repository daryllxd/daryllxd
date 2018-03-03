# frozen_string_literal: true

module Pomodoros
  class CreateService < Pomodoros::BaseService
    extend Memoist

    attr_reader :description, :duration, :tags, :errors, :duration_offset

    # tags: PomodoroActivityTag
    def initialize(description:, duration:, tags:, duration_offset: 0)
      @description = description
      @duration = duration.to_i
      @tags = tags
      @duration_offset = duration_offset
    end

    def call
      ActiveRecord::Base.transaction do
        steps.map do |step|
          result = step.call

          unless result.valid?
            @errors = result.errors
            raise ActiveRecord::Rollback
          end
        end

        return create_pomodoro!
      end

      return errors
    rescue StandardError => e
      DaryllxdError.new(e)
    end

    def steps
      [
        proc { create_pomodoro! },
        proc { create_tags! }
      ]
    end

    private

    def create_pomodoro!
      Pomodoro.create!(create_pomodoro_attributes)
    end

    def create_pomodoro_attributes
      {
        description: description,
        duration: duration,
        started_at: Time.current - duration.minutes - duration_offset.minutes
      }
    end

    def create_tags!
      tags.each do |tag|
        create_pomodoro!.pomodoro_activity_tags.create!(activity_tag: tag)
      end
    end

    memoize :create_pomodoro!
  end
end
