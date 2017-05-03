module Matches
  module Strokes
    class CreateService
      attr_reader :match_participant, :match, :teebox_hole, :value, :manual_junk

      def initialize(match_participant:, match:, teebox_hole:, value:, manual_junk: :no_junk)
        @match_participant = match_participant
        @match = match
        @teebox_hole = teebox_hole
        @value = value
        @manual_junk = manual_junk
      end

      def call
        Stroke.create!(
          match: match,
          match_participant: match_participant,
          teebox_hole: teebox_hole,
          value: value,
          manual_junk: adjust_manual_junk
        )
      end

      def adjust_manual_junk
        if manual_junk.empty?
          Stroke.manual_junks[:no_junk]
        else
          manual_junk
        end
      end
    end
  end
end
