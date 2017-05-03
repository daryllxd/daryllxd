module Matches
  module Strokes
    class MassCreateService < BaseService
      include ImplementsPolicies

      attr_reader :strokes, :match, :teebox_hole

      def initialize(match:, teebox_hole:, strokes:)
        @match = match
        @strokes = strokes
        @teebox_hole = teebox_hole
      end

      def policies
        [
          ::Strokes::Policies::EnsureAllParticipantsHaveStrokes,
          ::Strokes::Policies::EnsurePreviousHoleHasStrokes
        ]
      end

      def perform
        ActiveRecord::Base.transaction do
          new_strokes = strokes.map do |stroke_attr|
            Matches::Strokes::CreateService.new(
              match: match,
              teebox_hole: teebox_hole,
              match_participant: find_match_participant(stroke_attr[:match_participant_id]),
              value: stroke_attr[:value],
              manual_junk: stroke_attr[:manual_junk] || Stroke.default_manual_junk
            ).call
          end

          new_strokes
        end
      end

      private

      def find_match_participant(id)
        MatchParticipant.find_by_id(id)
      end
    end
  end
end
