# frozen_string_literal: true
module Matches
  class RecordPresenter < BasePresenter
    def initialize(model:)
      super(model: model)
    end

    def present
      {
        id: id,
        course_id: course_id,
        teebox_id: teebox_id,
        team_stake: team_stake,
        individual_stake: individual_stake
      }
    end
  end
end
