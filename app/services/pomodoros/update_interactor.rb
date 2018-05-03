# frozen_string_literal: true

module Pomodoros
  class UpdateInteractor
    extend Memoist

    attr_reader :found_pomodoro, :options, :tags

    def initialize(**options)
      @found_pomodoro = Pomodoro.find_by(id: options[:pomodoro_id])
      @tags = options.fetch(:tags) { [] }
      @options = options.except(:pomodoro_id, :tags)
    end

    def call
      return pomodoro_attributes unless pomodoro_attributes.valid?
      return no_pomodoros_found_error unless found_pomodoro
      return found_tags unless found_tags.valid?

      # Returns final result of UpdateService, regardless if Successful or Error
      updated_pomodoro
    end

    private

    def found_tags
      Pomodoros::TagResolver.call(
        tag_string: tags
      )
    end

    def updated_pomodoro
      Pomodoros::UpdateService.call(
        pomodoro: found_pomodoro,
        pomodoro_attributes: pomodoro_attributes.payload,
        tags: found_tags
      )
    end

    def no_pomodoros_found_error
      DaryllxdError.new(message: I18n.t('pomodoro.find.error_cannot_find'))
    end

    def pomodoro_attributes
      Pomodoros::Cli::PrepareAttributes.call(options)
    end

    memoize :updated_pomodoro, :pomodoro_attributes
  end
end
