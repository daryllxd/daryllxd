module Matches
  module Submatches
    class CreateSevenWaysService
      attr_reader :match, :match_grouping_attributes

      # mp means match participant (context is that a user is a different match participant for each match)
      # match_grouping_attributes: [
      # { submatch_participants: [[match_starter], [mp3]], stake: -9 }, # Indie match
      # { submatch_participants: [[match_starter], [mp4]], stake: 6 },
      # { submatch_participants: [[mp2], [mp3]] },
      # { submatch_participants: [[mp2], [mp4]] },
      # { submatch_participants: [[match_starter, mp2], [mp3, mp4]] }   # Team match
      # ]
      def initialize(match:, match_grouping_attributes:)
        @match = match
        @match_grouping_attributes = match_grouping_attributes
      end

      # rubocop:disable MethodLength
      def call
        match_grouping_attributes.each do |match_grouping_attribute|
          new_submatch = match.submatches.create!(submatch_attributes(match_grouping_attribute))
          new_submatch.apply_seven_ways_defaults

          team_designations = match_grouping_attribute[:submatch_participants]

          team_designations.each do |match_grouping_teammates|
            used_team_name = match_grouping_teammates[:team_name]
            submatch_grouping = new_submatch.submatch_groupings.create!(name: used_team_name)

            match_grouping_teammates[:members].each do |match_grouping_team_member|
              submatch_grouping.submatch_participants.create!(
                match_participant: match_grouping_team_member,
                submatch: new_submatch
              )
            end
          end
        end

        match.submatches
      end
      # rubocop:enable MethodLength

      def submatch_attributes(match_grouping_attribute)
        {
          match_type: Submatch::Types::SEVEN_WAYS,
          stake: match_grouping_attribute[:stake] || 0
        }
      end
    end
  end
end
