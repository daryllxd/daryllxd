module Matches
  module Scoring
    module Adapters
      class MatchParticipantToValue
        attr_reader :match_participant, :hole_range

        def initialize(match_participant:, hole_range_object: HoleRange.new(:overall))
          @match_participant = match_participant
          @hole_range = hole_range_object
        end

        def convert
          Matches::Scoring::Values::MatchParticipant.new(
            name: match_participant.participant.first_name,
            id: match_participant.id,
            handicap_value: match_participant.handicap_value,
            strokes: match_participant.strokes.map(&:value),
            manual_junks: match_participant.manual_junk_score
          )
        end
      end
    end
  end
end
