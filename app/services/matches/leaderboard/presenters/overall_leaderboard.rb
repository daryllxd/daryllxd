require 'ranker'

# Given a LeaderboardUser, create a Tally
module Matches
  module Leaderboard
    module Presenters
      class OverallLeaderboard
        attr_reader :users

        def initialize(users:)
          @users = users
        end

        def present
          users_with_ranks.sort.map do |user|
            {
              player: user.present,
              record: user.win_loss_tie_record,
              percentage: user.percentage,
              units: user.units,
              rank: user.rank
            }
          end
        end

        private

        def users_with_ranks
          ranked_users.map do |ranked_user_tiers|
            ranked_user_tiers.rankables.map do |ranked_users|
              ranked_users.ranked_user_from(ranked_user_tiers)
            end
          end.flatten
        end

        def ranked_users
          Ranker.rank(users, by: :units, strategy: :modified_competition)
        end
      end
    end
  end
end
