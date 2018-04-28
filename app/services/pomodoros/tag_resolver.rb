# frozen_string_literal: true

module Pomodoros
  class TagResolver < ::Pomodoros::BaseService
    extend Memoist

    attr_reader :tag_string

    def initialize(tag_string:)
      @tag_string = tag_string
    end

    def call
      return DaryllxdError.new(message: I18n.t('pomodoro.create.error_no_tags')) unless tag_string.present?
      return DaryllxdError.new(message: I18n.t('pomodoro.create.error_no_tags_found')) unless tag_string_found?

      found_tag_string
    end

    private

    def found_tag_string
      ActivityTag.where(shortcut: tag_string.split(''))
    end

    def tag_string_found?
      found_tag_string.present?
    end

    memoize :found_tag_string
  end
end
