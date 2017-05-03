module Matches
  module Leaderboard
    module Values
      class User
        include Comparable

        attr_reader :first_name, :last_name, :tally

        delegate :units, :percentage, :total_matches, :win_loss_tie_record, to: :tally

        def initialize(first_name:, last_name:, tally:)
          @first_name = first_name
          @last_name = last_name
          @tally = tally
        end

        def <=>(other)
          tally <=> other.tally
        end

        def present
          "#{first_name} #{last_name.first}"
        end

        def as_presented_hash
          {
            player: present,
            record: win_loss_tie_record,
            percentage: percentage,
            units: units
          }
        end

        def ranked_user_from(ranker_tier)
          rank_prefix = ranker_tier.rankables.many? ? 'T' : ''
          rank_string = "#{rank_prefix}#{ranker_tier.rank}"

          Matches::Leaderboard::Values::RankedUser.new(
            user: self,
            rank: rank_string
          )
        end
      end
    end
  end
end
