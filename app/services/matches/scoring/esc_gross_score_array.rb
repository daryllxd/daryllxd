## ESC-adjusted
module Matches
  module Scoring
    class EscGrossScoreArray
      attr_reader :handicap_value, :hole_par_values, :hole_range_object, :strokes

      # match_participant doesn't necessarily need to be an ActiveRecord object.
      def initialize(match_participant:, hole_par_values:,
                     hole_range_object: HoleRange.new(:overall))

        @handicap_value = match_participant.handicap_value
        @hole_par_values = hole_par_values
        @strokes = match_participant.strokes
        @hole_range_object = hole_range_object
      end

      def score_array
        @cached_score_array ||=
          begin
            hole_range_object.to_range.map do |index|
              Matches::Scoring::EscComputation.new(
                handicap_value: handicap_value,
                par_value: hole_par_values[index - 1],
                stroke_value: strokes[index - 1]
              ).compute
            end
          end
      end

      def final_score(hole_range_object = @hole_range_object)
        desired_range = hole_range_object.to_range_adjusted_for_zero_index
        score_array[desired_range].reduce(:+)
      end

      def presented_score_array
        strokes.zip(score_array).map do |(stroke, esc_adjusted)|
          stroke == esc_adjusted ? esc_adjusted : "#{esc_adjusted}*"
        end
      end
    end
  end
end
