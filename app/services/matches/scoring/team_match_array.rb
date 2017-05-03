module Matches
  module Scoring
    class TeamMatchArray
      attr_reader(:hole_range_object, :hole_handicap_values,
                  :requester, :competitor, :match_mode)

      def initialize(competitor:, hole_handicap_values:, requester:,
                     hole_range_object: HoleRange.new(:front_9),
                     match_mode: Submatch::SevenWays::MatchModes::DEFAULT)
        @competitor = competitor
        @hole_handicap_values = hole_handicap_values
        @hole_range_object = hole_range_object
        @match_mode = match_mode
        @requester = requester
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

      def calculate_scores(team, index)
        team.map do |team_member|
          team_member_stroke = team_member.strokes[index]

          if team_member_stroke
            team_member_stroke + handicap_for?(hole_handicap_values[index], team_member)
          end
        end
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
          Matches::Scoring::Computations::TeamMatchScoreArray.new(
            requester_score: calculate_scores(requester, index - 1).min,
            competitor_score: calculate_scores(competitor, index - 1).min,
            last_hole_score: acc
          ).compute
        end

        list_of_scores
      end

      def highest_ranking_player
        @cached_highest_ranking_player ||= (requester + competitor).min_by(&:handicap_value)
      end

      # Difference of greater than 0 but less than or equal to 18 would mean 1 extra stroke for the worse player
      # Difference of more than 18 but less than or equal to 36 would mean 2 extra strokes for the worse player
      def handicap_for?(teebox_hole_handicap_value, requester)
        handicap_difference = requester.handicap_value - highest_ranking_player.handicap_value

        if handicap_difference >= teebox_hole_handicap_value
          (-1 * (handicap_difference.div(18) + 1))
        else
          0
        end
      end
    end
  end
end
