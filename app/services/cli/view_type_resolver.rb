# frozen_string_literal: true

module Cli
  class ViewTypeResolver
    attr_reader :view_type_string

    def initialize(view_type_string:)
      @view_type_string = view_type_string
    end

    def call
      case view_type_string
      when 't' then Pomodoros::Presenters::ActivityTagBreakdown
      else Pomodoros::Presenters::ForDateRange
      end
    end
  end
end
