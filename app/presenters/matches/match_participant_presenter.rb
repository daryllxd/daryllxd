# frozen_string_literal: true
module Matches
  class MatchParticipantPresenter < BasePresenter
    def present
      {
        id: model.id,
        user_id: model.participant.id,
        email: participant.email,
        first_name: participant.first_name,
        handicap_value: presented_handicap_value,
        last_name: participant.last_name,
        automatic_junk_score: model.automatic_junk_score,
        manual_junk_score: model.manual_junk_score
      }
    end
  end
end
