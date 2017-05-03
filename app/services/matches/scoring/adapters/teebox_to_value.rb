module Matches
  module Scoring
    module Adapters
      class TeeboxToValue
        attr_reader :teebox, :teebox_holes

        def initialize(teebox:, teebox_holes: teebox.teebox_holes)
          @teebox = teebox
          @teebox_holes = teebox_holes
        end

        def convert
          Matches::Scoring::Values::Teebox.new(
            hole_handicap_values: teebox_holes.pluck(:handicap_value),
            hole_par_values: teebox_holes.pluck(:par_value)
          )
        end
      end
    end
  end
end
