module Matches
  module Leaderboard
    module Values
      class RankedUser < Delegator
        attr_reader :user, :rank

        def initialize(user:, rank:)
          @user = user
          @rank = rank
        end

        def __getobj__
          user
        end
      end
    end
  end
end
