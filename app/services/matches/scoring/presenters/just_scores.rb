# Contains an array of the submatches
module Matches
  module Scoring
    module Presenters
      class JustScores < MotherArray
        def present
          {
            scores: the_scores,
            aloha_enabled: submatch.aloha_enabled,
            aloha_value: submatch.aloha_value,
            final_score: compute_final_score,
            aloha_score: compute_aloha_score,
            units_won: compute_units_won,
            ways_won: compute_ways_won
          }
        end

        private

        def compute_units_won
          (compute_ways_won * submatch.stake) if compute_ways_won
        end

        # Front 9 match
        # Front 9 press
        # Back 9 match
        # Back 9 press
        def front_nine_match
          score_array_generator.new(match_params.merge(hole_range_object: HoleRange.new(:front_9)))
        end

        def front_nine_press
          Matches::Scoring::PressScoreArray.new(
            match_score_array: front_nine_match.score_array,
            match_mode: submatch.match_mode,
            hole_range_object: HoleRange.new(:front_9)
          )
        end

        def back_nine_match
          score_array_generator.new(match_params.merge(hole_range_object: HoleRange.new(:back_9)))
        end

        def back_nine_press
          Matches::Scoring::PressScoreArray.new(
            match_score_array: back_nine_match.score_array,
            match_mode: submatch.match_mode,
            hole_range_object: HoleRange.new(:back_9)
          )
        end

        def match_params
          {
            requester: requester,
            competitor: competitor,
            hole_handicap_values: teebox.hole_handicap_values,
            match_mode: submatch.match_mode
          }
        end
      end
    end
  end
end
