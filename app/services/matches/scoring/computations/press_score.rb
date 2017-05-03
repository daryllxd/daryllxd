module Matches
  module Scoring
    module Computations
      class PressScore
        attr_reader :last_press_tuple, :hole_match_score, :original_match_score, :last_press_value

        NEW_PRESS = [0].freeze
        WON_HOLE_MATCH_SCORE = 1
        LOST_HOLE_MATCH_SCORE = -1

        def initialize(last_press_tuple:, hole_match_score:)
          @last_press_tuple = last_press_tuple
          @original_match_score, *_other_press_values, @last_press_value = last_press_tuple
          @hole_match_score = hole_match_score
        end

        def compute
          return nil unless hole_match_score.present?
          return [hole_match_score] unless last_press_tuple.present?

          last_press_tuple.map { |score| score + hole_match_score } + opened_new_press
        end

        private

        def opened_new_press
          if winning_last_press_by_one_and_won || losing_last_press_by_one_and_lost
            NEW_PRESS
          else
            []
          end
        end

        def last_match_comparison_basis
          last_press_value ? last_press_value : original_match_score
        end

        def winning_last_press_by_one_and_won
          last_match_comparison_basis == 1 && hole_match_score == WON_HOLE_MATCH_SCORE
        end

        def losing_last_press_by_one_and_lost
          last_match_comparison_basis == -1 && hole_match_score == LOST_HOLE_MATCH_SCORE
        end
      end
    end
  end
end
