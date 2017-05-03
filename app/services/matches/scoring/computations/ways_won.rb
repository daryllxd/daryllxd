module Matches
  module Scoring
    module Computations
      class WaysWon < Matches::Scoring::Presenters::BaseArray
        def compute
          @cached_computation ||=
            begin
              Matches::Scoring::Presenters::JustScores
                .new(context)
                .present[:ways_won] || Matches::Scoring::Values::NullWaysWon.new
            end
        end

        private

        def context
          instance_values
            .except('cached_computation')
            .symbolize_keys
        end
      end
    end
  end
end
