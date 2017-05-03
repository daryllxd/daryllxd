module Matches
  module Scoring
    class MaxAlohaIncentiveComputation
      attr_reader :submatch, :requester, :competitor, :teebox

      def initialize(submatch:, teebox:, requester:, competitor:)
        @submatch = submatch
        @teebox = teebox
        @requester = requester
        @competitor = competitor
      end

      def call
        return 0 if before_seventeenth_hole?

        ways_won_if_lost_last_hole =
          begin
            if requester_is_winning?
              Matches::Scoring::Presenters::ScenarioAnalysisBeforeLastHole.new(
                scenario_analysis_params
              ).present[:loss][:ways_won] / 2
            else
              Matches::Scoring::Presenters::ScenarioAnalysisBeforeLastHole.new(
                scenario_analysis_params_reversed
              ).present[:loss][:ways_won] / 2
            end
          end

        [ways_won_if_lost_last_hole, 0].max
      end

      private

      def before_seventeenth_hole?
        Array(requester).first.strokes.length < 17
      end

      def requester_is_winning?
        Matches::Scoring::Presenters::ScenarioAnalysisBeforeLastHole.new(
          scenario_analysis_params
        ).present[:tie][:ways_won].positive?
      end

      def scenario_analysis_params
        {
          requester: requester,
          competitor: competitor,
          teebox: teebox,
          submatch: submatch.no_alohas,
          score_array_generator: submatch.score_array_generator
        }
      end

      def scenario_analysis_params_reversed
        scenario_analysis_params.merge(
          requester: competitor,
          competitor: requester
        )
      end
    end
  end
end
