module Matches
  module Scoring
    class TeeboxParValuesArray < Matches::Scoring::TeeboxInformationArray
      def score_array
        @_score_array ||= teebox_holes.map(&:par_value)
      end

      def final_score
        score_array.reduce(:+)
      end
    end
  end
end
