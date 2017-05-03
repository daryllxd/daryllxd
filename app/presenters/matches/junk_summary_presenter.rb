module Matches
  class JunkSummaryPresenter < BasePresenter
    def present
      {
        teebox: present_teebox,
        started_at: started_at,
        results: present_groupings,
        groupings:  junk_summary_match_groupings.map(&:to_h)
      }
    end

    private

    def present_teebox
      TeeboxPresenter.new(model: teebox).present
    end

    def present_groupings
      junk_summary_match_groupings.map(&:to_s)
    end

    def junk_summary_match_groupings
      model.team_submatch.submatch_groupings.map(&:to_junk_summary_submatch_grouping).sort
    end
  end
end
