# Given a User, create a hash of his stats
module Matches
  module Leaderboard
    module Presenters
      class PlayerStats
        attr_reader :user

        def initialize(user:)
          @user = user
        end

        def present
          {
            as_of_date: Date.current.to_formatted_s(:day_and_date),
            tallies: present_tallies,
            last_matches: present_last_matches
          }
        end

        private

        def present_tallies
          {
            overall: user_tally_aggregator.call.map(&:as_presented_hash),
            team: user_tally_aggregator.team_submatches.map(&:as_presented_hash),
            indie: user_tally_aggregator.indie_submatches.map(&:as_presented_hash)
          }
        end

        def present_last_matches
          user.matches.map { |match| match.to_match_record(user: user) }
        end

        def user_tally_aggregator
          @cached_user_tally_aggregator ||=
            begin
              UserTallyAggregator.new(users: User.where(id: user.id))
            end
        end
      end
    end
  end
end
