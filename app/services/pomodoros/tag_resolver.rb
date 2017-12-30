# frozen_string_literal: true
module Pomodoros
  class TagResolver < ::Pomodoros::BaseService
    attr_reader :tag_string

    def initialize(tag_string:)
      @tag_string = tag_string
    end

    def call
      if tag_string.present?
        ActivityTag.where(shortcut: tag_string.split(''))
      else
        []
      end
    end
  end
end
