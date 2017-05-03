# Given an ActiveRecord user and an array of ActiveRecord Submatches, create (unranked) LeaderboardUsers.
module Matches
  module Leaderboard
    class UserTallyAggregator
      attr_reader :users, :submatch_scope

      def initialize(users: User.includes(:submatches), submatch_scope: Submatch.all)
        @users = users
        @submatch_scope = submatch_scope
      end

      def call
        users.map do |user|
          Matches::Leaderboard::Adapters::UserToLeaderboardUser.new(
            user: user,
            submatches: user.submatches.merge(submatch_scope)
          ).convert
        end
      end

      def team_submatches
        self.class.new(
          users: users,
          submatch_scope: ::Submatches::Queries::Team.new.query
        ).call
      end

      def indie_submatches
        self.class.new(
          users: users,
          submatch_scope: ::Submatches::Queries::Indie.new.query
        ).call
      end
    end
  end
end
