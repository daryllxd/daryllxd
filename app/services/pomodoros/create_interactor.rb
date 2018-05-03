# frozen_string_literal: true

module Pomodoros
  class CreateInteractor
    extend Memoist

    attr_reader :tags, :options

    def initialize(options)
      @tags = options.fetch(:tags) { [] }
      @options = options.except(:tags)
    end

    def call
      return pomodoro_attributes unless pomodoro_attributes.valid?
      return found_tags unless found_tags.valid?

      if created_pomodoro.valid?
        created_pomodoro
      else
        DaryllxdError.new(message: I18n.t('pomodoro.create.error_on_pomodoro'))
      end
    end

    private

    def found_tags
      Pomodoros::TagResolver.call(tag_string: tags)
    end

    def pomodoro_attributes
      Pomodoros::Cli::PrepareAttributes.call(options)
    end

    def created_pomodoro
      Pomodoros::Create.call({ tags: found_tags }.merge(pomodoro_attributes.payload))
    end

    memoize :created_pomodoro
  end
end
