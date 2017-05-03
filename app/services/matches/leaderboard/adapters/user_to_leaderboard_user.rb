module Matches
  module Leaderboard
    module Adapters
      class UserToLeaderboardUser
        attr_reader :user, :submatches

        def initialize(user:, submatches:)
          @user = user
          @submatches = submatches
        end

        def convert
          Matches::Leaderboard::Values::User.new(
            first_name: user.first_name,
            last_name: user.last_name,
            tally: convert_submatches
          )
        end

        private

        def convert_submatches
          if submatches.present?
            Matches::Leaderboard::Values::TallyFactory
              .new(submatches_to_tally_entries)
              .tally_from_tally_entries
          else
            []
          end
        end

        def submatches_to_tally_entries
          submatches.map do |submatch|
            Matches::Leaderboard::Adapters::UserAndSubmatchToLeaderboardTallyEntry.new(
              user: user,
              submatch: submatch
            ).convert
          end
        end
      end
    end
  end
end
