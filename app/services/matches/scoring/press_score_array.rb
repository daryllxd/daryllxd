module Matches
  module Scoring
    class PressScoreArray
      HOLE_POSITION_START = 1

      attr_reader :hole_range_object, :match_mode, :match_score_array

      def initialize(
        match_score_array:,
        hole_range_object: HoleRange.new(:front_9),
        match_mode: Submatch::SevenWays::MatchModes::DEFAULT
      )

        @hole_range_object = hole_range_object
        @match_mode = match_mode
        @match_score_array = match_score_array
      end

      def score_array
        untransformed_press_scores_array =
          array_values.map do |hole_press_scores|
            single_press_score_presenter.new(score: hole_press_scores).present
          end

        press_score_array_transformer.new(
          press_score_array: untransformed_press_scores_array
        ).present
      end

      def final_score
        @cached_final_score ||=
          begin
            Matches::Scoring::Computations::PressFinalScore.new(
              hole_range_object: hole_range_object,
              match_mode: match_mode,
              score_array: array_values
            ).compute
          end
      end

      def to_h
        Presenters::MotherArrayRow.new(self).to_h(score_array: score_array)
      end

      def description
        "#{hole_range_object} Press"
      end

      def array_values
        _unused_acc, *list_of_scores = match_score_array.map_with_accumulator(nil) do |acc, index|
          Matches::Scoring::Computations::PressScore.new(
            last_press_tuple: acc,
            # Get the hole difference, not the absolute stroke. So 1, 0, -1.
            hole_match_score: acc && index ? index - acc.first : index
          ).compute
        end

        list_of_scores.pad_right(
          nil, list_of_scores.size,
          hole_range_object.size - list_of_scores.size
        )
      end

      private

      def array_values_just_presses
        array_values.map { |_match_score, *press_scores| press_scores }
      end

      def press_score_array_transformer
        Matches::Scoring::Presenters::PressScoreArrayTransformer
      end

      def single_press_score_presenter
        Matches::Scoring::Presenters::PressScoreEntry
      end
    end
  end
end
