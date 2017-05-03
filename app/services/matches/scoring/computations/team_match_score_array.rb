# In: Lowest stroke values for requester's team,
# lowest stroke values for the competitor's team,
# score of the last hole
module Matches
  module Scoring
    module Computations
      class TeamMatchScoreArray
        attr_reader :requester_score, :competitor_score, :last_hole_score

        def initialize(requester_score:, competitor_score:, last_hole_score:)
          @requester_score = requester_score
          @competitor_score = competitor_score
          @last_hole_score = last_hole_score || 0
        end

        def compute
          return nil unless requester_score.present? && competitor_score.present?

          score_result = requester_score - competitor_score

          added_score = if score_result.negative?
                          1
                        elsif score_result.positive?
                          -1
                        else
                          0
                        end

          added_score + last_hole_score
        end
      end
    end
  end
end
