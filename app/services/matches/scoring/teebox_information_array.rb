module Matches
  module Scoring
    class TeeboxInformationArray < Matches::Scoring::ScoreArray
      protected

      def teebox
        match.teebox
      end

      def teebox_holes
        teebox.teebox_holes.where(hole_number: hole_range)
      end
    end
  end
end
