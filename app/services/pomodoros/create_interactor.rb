# frozen_string_literal: true

module Pomodoros
  class CreateInteractor
    extend Memoist

    attr_reader :tags, :description, :duration, :duration_offset

    def initialize(options)
      @tags = options.fetch(:tags) { [] }
      @description = options.fetch(:description) { nil }
      @duration = options.fetch(:duration) { nil }
      @duration_offset = options.fetch(:duration_offset) { 0 }
    end

    def call
      return found_tags unless found_tags.valid?

      if created_pomodoro.valid?
        created_pomodoro
      else
        DaryllxdError.new(message: I18n.t('pomodoro.create.error_on_pomodoro'))
      end
    end

    private

    def found_tags
      Pomodoros::TagResolver.call(
        tag_string: tags
      )
    end

    def created_pomodoro
      Pomodoros::CreateService.call(
        description: description,
        duration: duration.to_i,
        duration_offset: duration_offset.to_i,
        tags: found_tags
      )
    end

    memoize :created_pomodoro
  end
end
