# frozen_string_literal: true
module Pomodoros
  class CreateService
    attr_reader :description, :duration, :tags

    def initialize(description:, duration:, tags:)
      @description = description
      @duration = duration
      @tags = tags
    end

    def call
      return DaryllxdError.new(I18n.t('pomodoro.create.error_no_tags')) unless tags.present?

      ActiveRecord::Base.transaction do
        create_pomodoro
        create_tags

        return created_pomodoro
      end
    end

    private

    def create_pomodoro
      @memoized_created_pomodoro ||= Pomodoro.create(create_pomodoro_attributes)
    end

    def create_pomodoro_attributes
      {
        description: description,
        duration: duration
      }
    end

    def create_tags
      tags.each do |tag|
        created_pomodoro.pomodoro_activity_tags.create(activity_tag: tag)
      end
    end

    def created_pomodoro
      @memoized_created_pomodoro
    end
  end
end
