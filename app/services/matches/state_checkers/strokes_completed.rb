module Matches
  module StateCheckers
    class StrokesCompleted
      delegate :teebox_holes, :strokes, :match_participants, to: :match

      attr_reader :match

      def initialize(match:)
        @match = match
      end

      def valid?
        match_participants_and_teebox_holes? && all_match_participants_have_stroked?
      end

      private

      def match_participants_and_teebox_holes?
        match_participants.count.positive? && teebox_holes.count.positive?
      end

      def all_match_participants_have_stroked?
        strokes.count == (match_participants.count * teebox_holes.count)
      end
    end
  end
end
