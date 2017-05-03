module Matches
  class FinishService < BaseService
    attr_reader :match

    def initialize(match:)
      @match = match
    end

    def perform
      if match.strokes_completed?
        match.finish
        match
      else
        Errors::InvalidOperation.new(
          "Match #{match.id} cannot be finished because its strokes are not yet completed."
        )
      end
    end
  end
end
