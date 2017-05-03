module Matches
  class SummaryPresenter < BasePresenter
    def present
      submatches.map do |submatch|
        ::Submatches::SummaryPresenter.new(
          model: submatch
        ).present
      end
    end
  end
end
