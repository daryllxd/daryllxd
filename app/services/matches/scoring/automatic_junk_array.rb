module Matches
  module Scoring
    class AutomaticJunkArray < Matches::Scoring::ScoreArray
      def score_array
        requester_strokes.map(&:automatic_junk_score)
      end

      def final_score
        score_array.reduce(:+)
      end
    end
  end
end
