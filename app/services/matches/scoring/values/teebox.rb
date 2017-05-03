module Matches
  module Scoring
    module Values
      class Teebox
        attr_reader :hole_handicap_values, :hole_par_values

        def initialize(hole_handicap_values:, hole_par_values:)
          @hole_handicap_values = hole_handicap_values
          @hole_par_values = hole_par_values
        end
      end
    end
  end
end
