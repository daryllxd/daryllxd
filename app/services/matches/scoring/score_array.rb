module Matches
  module Scoring
    class ScoreArray
      attr_reader :match, :requester, :participants, :hole_range

      # We will use hole_range throughout for brevity, but we initialize on a HoleRange object,
      # just to confuse with passing a Ruby Range (Range.new(x..y))
      def initialize(match:, requester:, hole_range_object: HoleRange.new(:front_9))
        @match = match
        @requester = ensure_match_participant(requester)
        @hole_range = hole_range_object
      end

      def score_array
        raise "Must implement as an array of 'hole_range' length.  This will represent the results for each hole."
      end

      def final_score
        raise "#{self.class.name} must implement 'final_score'"
      end

      def requester_strokes
        match.strokes_of(participant: requester, range: hole_range.to_range)
      end

      private

      # TODO: Remove this!
      def ensure_match_participant(requester)
        case requester.class.name
        when 'SubmatchParticipant'
          requester.match_participant
        when 'MatchParticipant'
          requester
        when 'User'
          match.match_participant_from_user(requester)
        else
          raise 'Not a match participant'
        end
      end
    end
  end
end
