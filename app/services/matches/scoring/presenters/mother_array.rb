# Contains a submatch's scoring summary
# rubocop:disable ClassLength
module Matches
  module Scoring
    module Presenters
      class MotherArray < BaseArray
        NUMBER_OF_HOLES_PER_MATCH = 18

        def present
          {
            requester: generate_names(requester),
            requester_ids: generate_ids(Array(requester)),
            competitor: generate_names(competitor),
            competitor_ids: generate_ids(Array(competitor)),
            scores: the_scores,
            stake: submatch.stake,
            aloha_enabled: submatch.aloha_enabled,
            aloha_value: submatch.aloha_value,
            final_score: compute_final_score,
            aloha_score: compute_aloha_score,
            ways_won: compute_ways_won,
            junk_score: compute_junk_score
          }
        end

        # If competitor won, then swtich teams
        def ensure_requester_wins
          if present[:ways_won].negative?
            self.class.new(
              context.to_h.merge(
                requester: competitor,
                competitor: requester
              )
            )
          else
            self
          end
        end

        def winner_string
          Matches::Scoring::Presenters::MotherArrayWinnerString.new(
            mother_array: self
          ).present
        end

        def strokes_completed?
          requester.first.strokes.count == 18
        end

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

        def back_nine_press_string
          {
            press_string: Matches::Scoring::Presenters::BackNinePressString.new(
              submatch: submatch,
              press_array_final_score: back_nine_press.to_h[:score_array].compact.last
            ).present
          }
        end

        def compute_aloha_score
          return 0 unless submatch.aloha_enabled && requester.first.completed_strokes?

          *_, score_before_last_hole, score_after_last_hole = back_nine_match.score_array
          last_hole_result = score_after_last_hole - score_before_last_hole

          last_hole_result * submatch.aloha_value
        end

        def compute_final_score
          Matches::Scoring::Computations::OverallMatchFinalScore.new(
            front_nine_score_array: front_nine_match.score_array,
            back_nine_score_array: back_nine_match.score_array
          ).compute || 0
        end

        private

        def the_scores
          [
            front_nine_match.to_h, front_nine_press.to_h,
            back_nine_match.to_h, back_nine_press.to_h.merge(back_nine_press_string)
          ]
        end

        def compute_ways_won
          compute_aloha_score +
            compute_match_and_press_scores +
            compute_final_score +
            compute_junk_score
        end

        def compute_match_and_press_scores
          final_scores = the_scores.map_fetch(:final_score).compact

          if final_scores.empty?
            0
          else
            final_scores.inject(:+)
          end
        end

        def compute_junk_score
          Matches::Scoring::Computations::OverallJunkScore.new(
            requester: requester,
            competitor: competitor,
            submatch: submatch,
            teebox: teebox
          ).compute ||= 0
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
# rubocop:enable ClassLength
