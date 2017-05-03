module Matches
  module Leaderboard
    module Values
      class TallyFactory < BaseTally
        attr_reader :tally_entries

        def initialize(tally_entries)
          @tally_entries = tally_entries
        end

        def tally_from_tally_entries
          new_tally_from(
            tally_entries.each_with_object(null_tally_entry) do |tally_entry, acc|
              null_tally_entry.keys.each { |key| acc[key] += tally_entry.public_send(key) }
            end
          )
        end

        private

        def new_tally_from(hash)
          Matches::Leaderboard::Values::Tally.new(hash)
        end

        def null_tally_entry
          { wins: 0, ties: 0, losses: 0, units: 0 }
        end
      end
    end
  end
end
