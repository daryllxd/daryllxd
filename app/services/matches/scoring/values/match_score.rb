module Matches
  module Scoring
    module Values
      class MatchScore
        attr_reader :score

        def initialize(score:)
          @score = score
        end
      end
    end
  end
end
