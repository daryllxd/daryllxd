# Contains an array of the submatches
module Matches
  module Scoring
    module Presenters
      class ScenarioAnalysisBeforeLastHole < BaseArray
        SURE_WIN_SCORE = 1
        SURE_LOSS_SCORE = 9

        def present
          {
            win: match_score_if(win_params),
            loss: match_score_if(loss_params),
            tie: match_score_if(tie_params)
          }
        end

        private

        def match_score_if(attrs)
          Matches::Scoring::Presenters::JustWaysWon.new(attrs.merge(default_mother_array_params)).present
        end

        def win_params
          {
            requester: requester.map { |mp| simulate_scenario_for(mp: mp, score: SURE_WIN_SCORE) },
            competitor: competitor.map { |mp| simulate_scenario_for(mp: mp, score: SURE_LOSS_SCORE) }
          }
        end

        def loss_params
          {
            requester: requester.map { |mp| simulate_scenario_for(mp: mp, score: SURE_LOSS_SCORE) },
            competitor: competitor.map { |mp| simulate_scenario_for(mp: mp, score: SURE_WIN_SCORE) }
          }
        end

        def tie_params
          {
            requester: requester.map { |mp| simulate_scenario_for(mp: mp, score: SURE_WIN_SCORE) },
            competitor: competitor.map { |mp| simulate_scenario_for(mp: mp, score: SURE_WIN_SCORE) }
          }
        end

        # For a completed match, it is still helpful for the match participants to view the what-ifs.
        def simulate_scenario_for(mp:, score:)
          mp.without_last_hole.append_to_strokes(score)
        end

        def default_mother_array_params
          {
            teebox: teebox,
            submatch: submatch,
            score_array_generator: score_array_generator
          }
        end
      end
    end
  end
end
