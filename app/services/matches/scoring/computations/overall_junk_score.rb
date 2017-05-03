module Matches
  module Scoring
    module Computations
      class OverallJunkScore
        attr_reader :requester, :competitor, :submatch, :teebox

        def initialize(
          requester:, competitor:,
          submatch:, teebox:
        )
          @requester = requester
          @competitor = competitor
          @submatch = submatch
          @teebox = teebox
        end

        def compute
          return 0 if indie_submatch? || requester.first.strokes.compact.count < 18

          if summed_junks(requester) > summed_junks(competitor)
            1
          elsif summed_junks(requester) < summed_junks(competitor)
            -1
          else
            0
          end
        end

        private

        def indie_submatch?
          requester.length == 1
        end

        def summed_junks(team)
          team.inject(0) do |running_score, team_member|
            running_score + team_member.manual_junks + calculate_automatic_junks(team_member)
          end
        end

        def calculate_automatic_junks(team_member)
          teebox
            .hole_par_values
            .zip(team_member.strokes.compact)
            .inject(0) do |running_score, (par_value, stroke_value)|
            running_score + [par_value - stroke_value, 0].max
          end
        end
      end
    end
  end
end
