module Matches
  module Scoring
    module Presenters
      # Interface to ensure that a score_array can be converted to a hash that can be placed inside a MotherArray.
      class MotherArrayRow
        attr_reader :score_array_instance

        def initialize(score_array_instance)
          @score_array_instance = score_array_instance
        end

        def to_h(override_hash = {})
          {
            name: score_array_instance.description,
            score_array: score_array_instance.score_array,
            final_score: score_array_instance.final_score
          }.merge(override_hash)
        end
      end
    end
  end
end
