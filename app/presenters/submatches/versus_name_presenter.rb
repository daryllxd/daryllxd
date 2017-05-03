module Submatches
  module VersusNamePresenter
    extend ActiveSupport::Concern

    def versus_name(submatch)
      submatch
        .grouped_by_teams
        .values
        .map do |team_members|
        team_members.map_fetch(:first_name).join('/')
      end.join(' vs ')
    end
  end
end
