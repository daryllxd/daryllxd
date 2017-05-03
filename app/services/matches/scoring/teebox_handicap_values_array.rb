module Matches
  module Scoring
    class TeeboxHandicapValuesArray < Matches::Scoring::TeeboxInformationArray
      def score_array
        @_score_array ||= teebox_holes.map(&:handicap_value)
      end

      def final_score
        ''
      end
    end
  end
end
