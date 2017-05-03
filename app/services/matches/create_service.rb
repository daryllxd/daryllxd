module Matches
  class CreateService < BaseService
    attr_reader :course, :participants, :started_by_user, :teebox, :match_groupings, :new_match

    def initialize(course:, teebox:, started_by_user:, **options)
      @course = course
      @started_by_user = started_by_user
      @teebox = teebox
      @participants = options.fetch(:participants, [])
      @match_groupings = options.fetch(:match_groupings, [])
      @wrong_params = ensure_no_excess_attributes(options.keys, allowed_optional_attributes)
    end

    def perform
      ActiveRecord::Base.transaction do
        @new_match = Match.create(match_create_attributes)

        if new_match.valid?
          new_match.add_as_participants(participants: participants)
          create_submatches
          new_match
        else
          record_invalid_error_from(new_match)
        end
      end
    end

    def pre_method_hooks
      [proc { @wrong_params }]
    end

    private

    def match_create_attributes
      {
        course: course,
        teebox: teebox,
        started_by_user: started_by_user,
        started_at: DateTime.current
      }
    end

    def allowed_optional_attributes
      [:participants, :match_groupings, :match_types]
    end

    def create_submatches
      Matches::Submatches::CreateSevenWaysService.new(
        match: new_match,
        match_grouping_attributes: convert_to_match_participants(match_groupings)
      ).call
    end

    def convert_to_match_participants(match_groupings)
      match_groupings.map do |match_grouping|
        team_names = pad_team_names(match_grouping[:team_names], match_grouping[:submatch_participants].count)

        converted_match_participants = match_grouping[:submatch_participants].zip(team_names).map do |team, team_name|
          {
            members: team.map do |user|
              new_match.match_participant_from_user(user)
            end,
            team_name: team_name
          }
        end

        {
          submatch_participants: converted_match_participants,
          stake: match_grouping[:stake]
        }
      end
    end

    # ['hehe'] => ['hehe, 'Team 2'] or ['hehe', 'Team 2, Team 3']
    def pad_team_names(existing_team_names, teams_count)
      index_adjuster = 1

      ensure_array = Array(existing_team_names)
      what_needs_to_be_filled = teams_count - ensure_array.count

      ensure_array.dup.fill(ensure_array.length, what_needs_to_be_filled) { |x| "Team #{x + index_adjuster}" }
    end
  end
end
