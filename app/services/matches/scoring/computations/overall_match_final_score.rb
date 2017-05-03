module Matches
  module Scoring
    module Computations
      class OverallMatchFinalScore
        attr_reader :front_nine_score_array, :back_nine_score_array

        def initialize(front_nine_score_array:, back_nine_score_array:)
          @front_nine_score_array = front_nine_score_array
          @back_nine_score_array = back_nine_score_array
        end

        def compute
          return nil if unable_to_win_yet?

          if running_score.positive?
            3
          elsif running_score.negative?
            -3
          else
            0
          end
        end

        def ways_given_final_score
          [compute, 0].max
        end

        private

        def unable_to_win_yet?
          !strokes_havent_been_completed? && not_yet_clinched?
        end

        def strokes_havent_been_completed?
          combined_array.compact.count == 18
        end

        def not_yet_clinched?
          front_nine_final_score.blank? ||
            back_nine_score_array.all?(&:blank?) ||
            running_score.abs <= combined_array.count(&:blank?)
        end

        def combined_array
          front_nine_score_array + back_nine_score_array
        end

        def front_nine_final_score
          front_nine_score_array.last
        end

        def running_score
          front_nine_final_score + back_nine_score_array.compact.last
        end
      end
    end
  end
end
