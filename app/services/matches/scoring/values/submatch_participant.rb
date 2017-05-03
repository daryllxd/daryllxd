module Matches
  module Scoring
    module Values
      class SubmatchParticipant
        attr_reader :id, :match_participant_id, :submatch_id

        def initialize(id:, match_participant_id:, submatch_id:)
          @id = id
          @match_participant_id = match_participant_id
          @submatch_id = submatch_id
        end
      end
    end
  end
end
