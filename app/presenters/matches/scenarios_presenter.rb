module Matches
  class ScenariosPresenter < BasePresenter
    include ::Submatches::VersusNamePresenter

    attr_reader :requester, :submatches

    # Requester = MatchParticipant
    def initialize(model:, requester:, submatches: model.submatches)
      super(model: model)
      @requester = requester
      @submatches = submatches
    end

    def present
      {
        id: model.id,
        submatches: present_submatches
      }
    end

    private

    def present_submatches
      submatches.order('id ASC').map do |submatch|
        {
          id: submatch.id,
          submatch_name: versus_name(submatch),
          scenarios:  present_scenarios(submatch)
        }
      end
    end

    def present_scenarios(submatch)
      Matches::Scoring::Presenters::ScenarioAnalysisBeforeLastHole.new(
        match_array_params(submatch)
      ).present
    end

    def match_array_params(submatch)
      requester_team, competitor_team = check_requester_perspective(submatch)

      {
        teebox: teebox.to_scoring_value,
        submatch: submatch.to_value,
        requester: requester_team,
        competitor: competitor_team,
        score_array_generator: submatch.score_array_generator
      }
    end

    def check_requester_perspective(submatch)
      Matches::Scoring::PerspectiveCheck.new(
        requester: requester.convert_to_score_array_params,
        teams: submatch.submatch_participants_to_match_participants_value
      ).call
    end
  end
end
