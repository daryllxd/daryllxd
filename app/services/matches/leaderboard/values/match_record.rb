module Matches
  module Leaderboard
    module Values
      class MatchRecord
        attr_reader :user, :results

        def initialize(user:, results:)
          @user = user
          @results = results
        end
      end
    end
  end
end
