module Matches
  class BoxScorePresenter < BasePresenter
    def present
      { participants: participants_hash }
    end

    private

    def participants_hash
      [
        unordered_participants_hash[0],
        unordered_participants_hash[1].merge(submatches: reorder(unordered_participants_hash[1])),
        unordered_participants_hash[2],
        unordered_participants_hash[3].merge(submatches: reorder(unordered_participants_hash[3]))
      ]
    end

    def reorder(unordered_participants_hash_row)
      [
        unordered_participants_hash_row[:submatches][0],
        unordered_participants_hash_row[:submatches][2],
        unordered_participants_hash_row[:submatches][1]
      ]
    end

    def unordered_participants_hash
      @cached_unordered_participants_hash ||= match_participants_query.map do |match_participant|
        {
          id: match_participant.id,
          name: match_participant.name,
          is_settled: match_participant.is_settled?,
          submatches: present_submatches(match_participant.id),
          record: present_record(match_participant),
          damages: present_submatches(match_participant.id).map_fetch(:damages).compact.sum
        }
      end
    end

    def match_participants_query
      MatchParticipant.join_users(match_id: id)
    end

    def present_record(match_participant)
      Matches::Leaderboard::Adapters::MatchToMatchRecord.new(
        user: match_participant.participant,
        match: model
      ).convert.results[:record]
    end

    def present_submatches(match_participant_id)
      submatches_data_hash.each_with_object([]) do |submatch, acc|
        if submatch[:requester_ids].include? match_participant_id
          acc << summary_hash_from_submatch(submatch: submatch)
        end

        if submatch[:competitor_ids].include? match_participant_id
          acc << reverse_summary_hash_from_submatch(submatch: submatch)
        end
      end
    end

    def summary_hash_from_submatch(submatch:)
      {
        ways_won: submatch[:ways_won],
        stake: submatch[:stake],
        competitor_ids: submatch[:competitor_ids],
        competitor_names: submatch[:competitor],
        damages: submatch[:ways_won].present? ? submatch[:ways_won] * submatch[:stake] : nil
      }
    end

    def reverse_summary_hash_from_submatch(submatch:)
      summary_hash = summary_hash_from_submatch(submatch: submatch)

      summary_hash.merge(
        ways_won: summary_hash[:ways_won].present? ? summary_hash[:ways_won] * -1 : summary_hash[:ways_won],
        damages: summary_hash[:damages].present? ? summary_hash[:damages] * -1 : summary_hash[:damages],
        competitor_ids: submatch[:requester_ids],
        competitor_names: submatch[:requester]
      )
    end

    def submatches_query
      Submatch
        .select('submatches.*, teebox_holes.hole_number, users.first_name as name')
        .eager_load(match: [teebox: :teebox_holes])
        .eager_load(submatch_participants: [match_participant: :participant])
        .where('matches.id = ?', id)
    end

    def submatches_data_hash
      @cached_submatches_data_hash ||=
        begin
          submatches_query.map do |submatch|
            Matches::Scoring::Presenters::MotherArray.new(
              mother_array_params(submatch)
            ).present
          end
        end
    end

    def mother_array_params(submatch)
      requester_team, competitor_team = submatch.submatch_participants_to_match_participants_value

      {
        teebox: teebox.to_scoring_value,
        submatch: submatch.to_value,
        score_array_generator: submatch.score_array_generator,
        requester: requester_team,
        competitor: competitor_team
      }
    end
  end
end
