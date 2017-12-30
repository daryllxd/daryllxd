# frozen_string_literal: true
module Pomodoros
  class CreateInteractor
    attr_reader :tags, :description, :duration

    def initialize(options)
      @tags = options.fetch(:tags) { [] }
      @description = options.fetch(:description) { nil }
      @duration = options.fetch(:duration) { nil }
    end

    def call
      return DaryllxdError.new(I18n.t('pomodoro.create.error_no_tags')) unless found_tags.present?

      if created_pomodoro.valid?
        created_pomodoro
      else
        DaryllxdError.new(I18n.t('pomodoro.create.error_on_pomodoro'))
      end
    end

    private

    def found_tags
      Pomodoros::TagResolver.call(
        tag_string: tags
      )
    end

    def created_pomodoro
      @memoized_created_pomodoro ||=
        begin
          Pomodoros::CreateService.call(
            description: description,
            duration: duration,
            tags: found_tags
          )
        end
    end
  end
end
