# Contains an array of the submatches
module Matches
  module Scoring
    module Presenters
      class JustWaysWon < MotherArray
        def present
          {
            ways_won: compute_ways_won
          }
        end

        # Do not include junk score in calculating WaysWon for ScenarioAnalysis
        def compute_ways_won
          super - compute_junk_score if super
        end
      end
    end
  end
end
