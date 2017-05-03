module Matches
  module Scoring
    module Values
      class NullWaysWon
        def positive?
          false
        end

        def zero?
          false
        end

        def negative?
          false
        end

        def present?
          false
        end
      end
    end
  end
end
