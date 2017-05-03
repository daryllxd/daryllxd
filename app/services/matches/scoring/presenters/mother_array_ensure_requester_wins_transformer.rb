module Matches
  module Scoring
    module Presenters
      class MotherArrayEnsureRequesterWinsTransformer
        attr_reader :mother_array_hash

        def initialize(mother_array_hash:)
          @mother_array_hash = mother_array_hash
        end

        def transform
          return mother_array_hash if requester_won_or_tied?

          mother_array_hash.merge(
            requester: mother_array_hash[:competitor],
            requester_ids: mother_array_hash[:competitor_ids],
            competitor: mother_array_hash[:requester],
            competitor_ids: mother_array_hash[:requester_ids],
            scores: reverse_scores,
            final_score: (mother_array_hash[:final_score] * -1),
            aloha_score: (mother_array_hash[:aloha_score] * -1),
            ways_won: (mother_array_hash[:ways_won] * -1)
          )
        end

        private

        def requester_won_or_tied?
          mother_array_hash[:ways_won].blank? || mother_array_hash[:ways_won] >= 0
        end

        def reverse_scores
          mother_array_hash[:scores].map do |scores|
            {
              name: scores[:name],
              score_array: (scores[:score_array].map { |x| x * -1 }),
              final_score: scores[:final_score] * -1
            }
          end
        end
      end
    end
  end
end
