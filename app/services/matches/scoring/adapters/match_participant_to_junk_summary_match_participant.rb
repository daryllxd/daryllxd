module Matches
  module Scoring
    module Adapters
      class MatchParticipantToJunkSummaryMatchParticipant
        attr_reader :match_participant, :strokes

        def initialize(match_participant:, strokes: Stroke.where(match_participant: match_participant))
          @match_participant = match_participant
          @strokes = strokes
        end

        def convert
          Matches::Scoring::Values::JunkSummaryMatchParticipant.new(
            match_participant: {
              id: match_participant.id,
              name: match_participant.participant.first_name
            },
            junk_scores: {
              total: automatic_junk_score + manual_junk_score,
              automatic_junk_score: automatic_junk_score,
              manual_junk_score: manual_junk_score
            },
            junks: build_junk_array
          )
        end

        private

        def automatic_junk_score
          strokes.map(&:automatic_junk_score).compact.inject(:+) || 0
        end

        def manual_junk_score
          strokes.map(&:manual_junk_score).compact.inject(:+) || 0
        end

        def build_junk_array
          strokes.map do |stroke|
            next unless stroke.total_junk_score.positive?

            hole_number_string = "Hole #{stroke.teebox_hole.hole_number}"
            junk_string = [stroke.manual_junk_string, stroke.automatic_junk_string].reject(&:empty?).join('/')
            junk_score = "(#{stroke.total_junk_score})"

            [hole_number_string, junk_string, junk_score].join(' ')
          end.compact.flatten
        end
      end
    end
  end
end
