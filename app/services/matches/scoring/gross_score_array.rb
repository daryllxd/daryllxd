## Gross Gross
module Matches
  module Scoring
    class GrossScoreArray < Matches::Scoring::ScoreArray
      def score_array
        requester_strokes.map(&:value)
      end

      def final_score
        score_array.reduce(:+)
      end
    end
  end
end
