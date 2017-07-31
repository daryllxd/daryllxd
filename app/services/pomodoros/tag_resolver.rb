# frozen_string_literal: true
module Pomodoros
  class TagResolver
    attr_reader :tag_string

    def initialize(tag_string:)
      @tag_string = tag_string
    end

    def call
      ActivityTag.where(shortcut: tag_string.split(''))
    end
  end
end
