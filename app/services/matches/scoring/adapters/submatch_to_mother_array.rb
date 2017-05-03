module Matches
  module Scoring
    module Adapters
      class SubmatchToMotherArray
        attr_reader :submatch, :requester, :mother_array_class

        def initialize(submatch:, requester:, mother_array_class: Matches::Scoring::Presenters::MotherArray)
          @submatch = submatch
          @requester = requester
          @mother_array_class = mother_array_class
        end

        def convert
          mother_array_class.new(match_array_params)
        end

        def match_array_params
          requester_team, competitor_team = check_requester_perspective

          {
            teebox: submatch.match.teebox.to_scoring_value,
            submatch: submatch.to_value,
            requester: requester_team,
            competitor: competitor_team,
            score_array_generator: submatch.score_array_generator
          }
        end

        def check_requester_perspective
          Matches::Scoring::PerspectiveCheck.new(
            requester: requester.convert_to_score_array_params,
            teams: submatch.submatch_participants_to_match_participants_value
          ).call
        end
      end
    end
  end
end
