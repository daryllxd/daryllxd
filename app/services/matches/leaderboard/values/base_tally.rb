module Matches
  module Leaderboard
    module Values
      class BaseTally
        attr_reader :wins, :losses, :ties, :units

        def initialize(wins:, losses:, ties:, units:)
          @wins = wins.to_f
          @losses = losses.to_f
          @ties = ties.to_f
          @units = units
        end
      end
    end
  end
end
