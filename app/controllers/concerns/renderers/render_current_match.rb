module Renderers
  module RenderCurrentMatch
    extend ActiveSupport::Concern

    def render_current_match(
      match: @match,
      requester: current_user,
      status: 200
    )
      passed_in_requester = ensured_requester(match, requester)

      if passed_in_requester
        render json: {
          match: MatchPresenter.new(
            model: match,
            requester: passed_in_requester
          ).present
        }, status: status
      else
        render_error(message: 'Match requester not found')
      end
    end

    # Type checking workaround, sometimes the passed current_user becomes a MatchParticipant (???)
    def ensured_requester(match, requester)
      if requester.class == MatchParticipant
        requester
      elsif requester.class == User
        match.match_participant_from_user(requester)
      else
        false
      end
    end
  end
end
