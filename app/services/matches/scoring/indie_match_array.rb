module Matches
  module Scoring
    class IndieMatchArray
      attr_reader(:competitor, :hole_range_object, :match_mode,
                  :requester, :hole_handicap_values)

      def initialize(competitor:, hole_handicap_values:, requester:,
                     match_mode: Submatch::SevenWays::MatchModes::DEFAULT,
                     hole_range_object: HoleRange.new(:front_9))

        @requester = Array(requester).first
        @competitor = Array(competitor).first
        @hole_range_object = hole_range_object
        @hole_handicap_values = hole_handicap_values
        @match_mode = match_mode
      end

      def score_array
        @cached_score_array ||= compute_score_array
      end

      def final_score
        Matches::Scoring::Computations::IndieFinalScore.new(
          hole_range_object: hole_range_object,
          match_mode: match_mode,
          score_array: score_array
        ).compute
      end

      def to_h
        Presenters::MotherArrayRow.new(self).to_h
      end

      def description
        "#{hole_range_object} Match"
      end

      private

      def compute_score_array
        _unused_acc, *list_of_scores = hole_range_object.to_range.map_with_accumulator(0) do |acc, index|
          Matches::Scoring::Computations::IndieMatchScore.new(
            teebox_hole_handicap_value: hole_handicap_values[index - 1],
            competitor_handicap: competitor.handicap_value,
            competitor_value: competitor.strokes[index - 1],
            requester_handicap: requester.handicap_value,
            requester_value: requester.strokes[index - 1],
            last_score: acc
          ).compute
        end

        list_of_scores
      end
    end
  end
end
