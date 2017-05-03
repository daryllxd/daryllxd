module Matches
  module Scoring
    module Values
      class JunkSummaryMatchGrouping
        include Comparable

        attr_reader :match_participants

        def initialize(match_participants:)
          @match_participants = match_participants
        end

        def <=>(other)
          other.total_junks <=> total_junks
        end

        def total_junks
          match_participants.sum(&:total_junks)
        end

        def to_s
          "#{match_participant_names}: #{total_junks}"
        end

        def to_h
          match_participants.map(&:to_h)
        end

        def match_participant_names
          match_participants.map(&:name).join('/')
        end
      end
    end
  end
end
