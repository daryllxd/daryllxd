module Matches
  module Scoring
    class EscComputation
      attr_reader :handicap_value, :par_value, :stroke_value

      def initialize(handicap_value:, par_value:, stroke_value:)
        @handicap_value = handicap_value
        @par_value = par_value
        @stroke_value = stroke_value
      end

      def compute
        case handicap_value
        when (0..9)
          [double_bogey, stroke_value].min
        when (10..19)
          [7, stroke_value].min
        when (20..29)
          [8, stroke_value].min
        when (30..39)
          [9, stroke_value].min
        else
          [10, stroke_value].min
        end
      end

      private

      def double_bogey
        par_value + 2
      end
    end
  end
end
