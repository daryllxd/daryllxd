module Matches
  module Scoring
    module Adapters
      class SubmatchGroupingToJunkSummaryMatchGrouping
        attr_reader :submatch_grouping

        def initialize(submatch_grouping:)
          @submatch_grouping = submatch_grouping
        end

        def convert
          Matches::Scoring::Values::JunkSummaryMatchGrouping.new(
            match_participants: convert_submatch_grouping_to_match_participants
          )
        end

        private

        def convert_submatch_grouping_to_match_participants
          submatch_grouping.match_participants.map do |match_participant|
            Matches::Scoring::Adapters::MatchParticipantToJunkSummaryMatchParticipant.new(
              match_participant: match_participant
            ).convert
          end
        end
      end
    end
  end
end
