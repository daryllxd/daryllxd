module Matches
  module Scoring
    module Computations
      class IndieFinalScore
        attr_reader :hole_range_object, :match_mode, :score_array

        def initialize(hole_range_object:, match_mode:, score_array:)
          @hole_range_object = hole_range_object
          @match_mode = match_mode
          @score_array = score_array
        end

        def compute
          if unable_to_win_yet?
            nil
          elsif able_to_win?
            valid_for_doubling? ? (base_points_for * 2) : base_points_for
          end
        end

        def ways_given_final_score
          [compute, 0].max
        end

        private

        def base_points_for
          if running_final_score.positive?
            2
          elsif running_final_score.negative?
            -2
          else
            0
          end
        end

        def able_to_win?
          clinched? || completed_score_array?
        end

        def unable_to_win_yet?
          score_array.compact.length < (hole_range_object.size / 2)
        end

        def completed_score_array?
          score_array.compact == score_array
        end

        # Ex: If the someone leads by 2 before the last hole,
        # the other team can't catch up. So the final score is scored already
        def clinched?
          score_array.compact.last.abs > score_array.count(&:blank?)
        end

        def valid_for_doubling?
          hole_range_object.back_nine? && back_nine_is_doubled?
        end

        def back_nine_is_doubled?
          [
            Submatch::SevenWays::MatchModes::DOUBLED_BACK,
            Submatch::SevenWays::MatchModes::SEVEN_WAY_BACK
          ].include? match_mode
        end

        def running_final_score
          score_array.compact.last
        end
      end
    end
  end
end
