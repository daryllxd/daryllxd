# Given a User and Match, return a MatchSummary
# A MatchSummary is made of a User and TallyEntries
module Matches
  module Leaderboard
    module Adapters
      class MatchToMatchRecord
        attr_reader :user, :match

        def initialize(user:, match:)
          @user = user
          @match = match
        end

        def convert
          return [] unless match.participants.include?(user)

          Matches::Leaderboard::Values::MatchRecord.new(
            user: user.to_leaderboard_user,
            results: {
              record: consolidated_tally.win_loss_tie_record,
              ways_won_total: consolidated_tally.units,
              ways_won_indie: consolidated_indie_tally.units,
              ways_won_team: consolidated_team_tally.units
            }
          )
        end

        private

        def consolidate_tally_from(tally_entries)
          Matches::Leaderboard::Values::TallyFactory.new(
            tally_entries
          ).tally_from_tally_entries
        end

        def consolidated_tally
          consolidate_tally_from(submatch_tally_entries)
        end

        def consolidated_indie_tally
          consolidate_tally_from(submatch_tally_entries.select(&:indie?))
        end

        def consolidated_team_tally
          consolidate_tally_from(submatch_tally_entries.select(&:team?))
        end

        def submatch_tally_entries
          @cached_submatch_tally_entires ||=
            begin
              Users::Queries::UserSubmatchesFromMatches.new(
                user: user,
                relation: Match.where(id: match)
              ).query.map do |submatch|
                submatch.to_tally_entry(user: user)
              end
            end
        end
      end
    end
  end
end
