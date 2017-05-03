module Matches
  module Scoring
    module Computations
      class JunkMatchFinalScore
        attr_reader :requester, :competitor

        def initialize(requester:, competitor:)
          @requester = Array(requester)
          @competitor = Array(competitor)
        end

        def compute
          difference = requester.map(&:manual_junks).inject(:+) - competitor.map(&:manual_junks).inject(:+)

          if difference.positive?
            1
          elsif difference.negative?
            -1
          else
            0
          end
        end
      end
    end
  end
end
