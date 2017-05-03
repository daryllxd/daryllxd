module Submatches
  class SummaryPresenter < BasePresenter
    include Submatches::VersusNamePresenter

    def present
      {
        submatch_name: versus_name(model),
        winner: mother_array.winner_string,
        scores: [
          front_nine: front_nine_hash,
          back_nine: back_nine_hash,
          overall: overall_hash
        ]
      }
    end

    private

    def mother_array
      @cached_mother_array ||=
        begin
          model.to_mother_array(requester: model.match_participants.first).ensure_requester_wins
        end
    end

    def front_nine_hash
      {
        ways_won: mother_array.front_nine_match.final_score + mother_array.front_nine_press.final_score,
        press_string: mother_array.front_nine_press.score_array.last
      }
    end

    def back_nine_hash
      {
        ways_won: mother_array.back_nine_match.final_score + mother_array.back_nine_press.final_score +
          mother_array.compute_aloha_score,
        press_string: mother_array.back_nine_press_string
      }
    end

    def overall_hash
      {
        ways_won: mother_array.compute_final_score,
        winner_string: '1 & 1'
      }
    end
  end
end
