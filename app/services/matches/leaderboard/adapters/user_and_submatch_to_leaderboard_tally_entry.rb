module Matches
  module Leaderboard
    module Adapters
      class UserAndSubmatchToLeaderboardTallyEntry
        attr_reader :user, :submatch

        def initialize(user:, submatch:)
          @user = user
          @submatch = submatch
        end

        def convert
          if submatch_participants_include_user?
            Matches::Leaderboard::Values::TallyEntry.new(
              wins: boolean_to_int(ways_won.positive?),
              ties: boolean_to_int(ways_won.zero?),
              losses: boolean_to_int(ways_won.negative?),
              units: ways_won.present? ? (submatch.stake * ways_won).to_i : 0,
              submatch_type: deduce_match_type
            )
          else
            Matches::Leaderboard::Values::TallyEntry.null_tally_entry
          end
        end

        private

        def deduce_match_type
          submatch.indie? ? 'indie' : 'team'
        end

        def boolean_to_int(conditional)
          conditional ? 1 : 0
        end

        def submatch_participants_include_user?
          submatch_participants_value.flatten.map(&:id).include?(
            user_as_submatch_participant.map(&:match_participant_id).first
          )
        end

        def submatch_participants_value
          @cached_submatch_participants_value ||= submatch.submatch_participants_to_match_participants_value
        end

        def requester_team
          submatch_participants_value.first
        end

        def competitor_team
          submatch_participants_value.last
        end

        def user_as_submatch_participant
          user.submatch_participants.merge(submatch.submatch_participants)
        end

        def ways_won
          @cached_ways_won ||=
            begin
              Matches::Scoring::Computations::WaysWon.new({
                submatch: submatch.to_value,
                teebox: submatch.match.teebox.to_scoring_value,
                score_array_generator: submatch.score_array_generator
              }.merge(adjusted_teams)).compute
            end
        end

        def adjusted_teams
          if competitor_team.map(&:id).include?(user_as_submatch_participant.map(&:match_participant_id).first)
            {
              requester: competitor_team,
              competitor: requester_team
            }
          else
            {
              requester: requester_team,
              competitor: competitor_team
            }
          end
        end
      end
    end
  end
end
