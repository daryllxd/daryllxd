module Matches
  module Scoring
    module Computations
      class PressFinalScore
        attr_reader :hole_range_object, :match_mode, :score_array

        def initialize(hole_range_object:, match_mode:, score_array:)
          @hole_range_object = hole_range_object
          @match_mode = match_mode
          @score_array = score_array
        end

        def compute
          return nil if unable_to_win_yet?
          return 0 if no_press?

          if can_get_points?
            valid_for_doubling ? (calculated_score * 2) : calculated_score
          end
        end

        def ways_given_final_score
          [compute, 0].max
        end

        private

        def unable_to_win_yet?
          score_array.compact.length < (hole_range_object.size / 2)
        end

        def no_press?
          running_final_score.length <= 1
        end

        def can_get_points?
          completed_score_array? || clinched?(running_final_score.second)
        end

        def completed_score_array?
          score_array.compact == score_array
        end

        def clinched?(individual_press_score)
          individual_press_score.abs > score_array.count(&:blank?)
        end

        def running_final_score
          score_array.compact.last
        end

        def running_final_press_scores
          _match_score, *press_scores = running_final_score
          press_scores
        end

        def calculated_score
          Array(running_final_press_scores).inject(0) do |total, press_result|
            if clinched?(press_result) && press_result.positive?
              total + 1
            elsif clinched?(press_result) && press_result.negative?
              total - 1
            else
              total
            end
          end
        end

        def valid_for_doubling
          hole_range_object.back_nine? && back_nine_is_doubled
        end

        def back_nine_is_doubled
          [
            Submatch::SevenWays::MatchModes::DOUBLED_BACK
          ].include? match_mode
        end
      end
    end
  end
end
