module Matches
  module Scoring
    module Presenters
      class PressScoreArrayTransformer
        EXPECTED_PRESS_SCORE_ARRAY_LENGTH = 9
        TWO_UP_OR_DOWN = '2/0'.freeze
        PRESS_SEPARATOR = '/'.freeze
        # press_score_array is expected to be an array with 9 length
        attr_reader :press_score_array

        def initialize(press_score_array:)
          @press_score_array = press_score_array
        end

        def present
          if no_two_up_or_down_earlier? && last_score == TWO_UP_OR_DOWN
            first_scores + [transformed_last_score]
          elsif last_hole_opened_press_unnecessarily?
            first_scores + [unopened_last_score]
          else
            press_score_array
          end
        end

        private

        def last_hole_opened_press_unnecessarily?
          last_hole? && last_hole_opened_press?
        end

        def last_hole?
          press_score_array.compact.length == EXPECTED_PRESS_SCORE_ARRAY_LENGTH
        end

        def last_hole_opened_press?
          first_scores.last.count(PRESS_SEPARATOR) == (last_score.count(PRESS_SEPARATOR) - 1)
        end

        def unopened_last_score
          last_score
            .split(PRESS_SEPARATOR)
            .drop_last(1)
            .join(PRESS_SEPARATOR)
        end

        def transformed_last_score
          if first_scores.last == '1 UP'
            '2 UP'
          elsif first_scores.last == '1 DN'
            '2 DN'
          else
            last_score
          end
        end

        def no_two_up_or_down_earlier?
          first_scores.none? { |score| score == TWO_UP_OR_DOWN }
        end

        def first_scores
          *first, _last = press_score_array
          first
        end

        def last_score
          press_score_array.last
        end
      end
    end
  end
end
