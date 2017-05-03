module Matches
  module Scoring
    module Computations
      class IndieMatchScore
        HOLE_THRESHOLD = 18

        attr_reader(:teebox_hole_handicap_value, :requester_handicap,
                    :competitor_value, :competitor_handicap,
                    :requester_value, :last_score)

        # rubocop:disable ParameterLists
        # I'm not sure how I can shorten the parameter list without dividing the class.
        # I don't want  to divide this class since computations should be in one file to make
        # it easier to visualize.
        def initialize(teebox_hole_handicap_value:, requester_handicap:,
                       competitor_handicap:, requester_value:,
                       competitor_value:, last_score:)
          @teebox_hole_handicap_value = teebox_hole_handicap_value
          @requester_value = requester_value
          @requester_handicap = requester_handicap
          @competitor_value = competitor_value
          @competitor_handicap = competitor_handicap
          @last_score = last_score
        end
        # rubocop:enable ParameterLists

        def compute
          return nil if value_to_add_to_score.nil?

          value_to_add_to_score + (last_score ? last_score : 0)
        end

        def handicap_for_teebox_hole_handicap_value
          return 0 if difference_between_handicaps_is_too_small?

          adjuster = handicap_difference_relative_to_the_hole.div(HOLE_THRESHOLD) + 1

          handicap_difference.negative? ? adjuster : (-1 * adjuster)
        end

        private

        # Requester has a higher handicap (they are worse), so they will get a 1 stroke incentive
        def value_to_add_to_score
          @_value_to_add_to_score ||= if requester_value.nil? && competitor_value.nil?
                                        nil
                                      elsif computed_handicap_score.positive?
                                        -1
                                      elsif computed_handicap_score.negative?
                                        1
                                      else
                                        0
                                      end
        end

        def computed_handicap_score
          @cached_computed_handicap_score ||=
            begin
              requester_value + handicap_for_teebox_hole_handicap_value - competitor_value
            end
        end

        # Difference of greater than 0 but less than or equal to 18 would mean 1 extra stroke for the worse player
        # Difference of more than 18 but less than or equal to 36 would mean 2 extra strokes for the worse player
        def difference_between_handicaps_is_too_small?
          handicap_difference.abs < teebox_hole_handicap_value
        end

        def handicap_difference
          requester_handicap - competitor_handicap
        end

        def handicap_difference_relative_to_the_hole
          handicap_difference.abs - teebox_hole_handicap_value
        end
      end
    end
  end
end
