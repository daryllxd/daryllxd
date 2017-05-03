module Matches
  module Scoring
    module Values
      class JunkSummaryMatchParticipant
        attr_reader :match_participant, :junk_scores, :junks

        def initialize(match_participant:, junk_scores:, junks:)
          @match_participant = match_participant
          @junk_scores = junk_scores
          @junks = junks
        end

        def name
          match_participant[:name]
        end

        def total_junks
          junk_scores[:total]
        end

        def to_h
          {
            match_participant: match_participant,
            junks: junks,
            junk_scores: junk_scores
          }
        end
      end
    end
  end
end
