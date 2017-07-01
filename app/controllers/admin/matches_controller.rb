# frozen_string_literal: true
module Admin
  class MatchesController < ApplicationController
    def show
      match = Match.find_by_id(params[:id])

      @match = MatchPresenter.new(
        model: match,
        requester: match.match_participants.last
      ).present.as_json
    end
  end
end
