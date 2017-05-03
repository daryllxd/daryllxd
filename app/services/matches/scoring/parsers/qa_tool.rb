require 'csv'

# rubocop:disable ClassLength
module Matches
  module Scoring
    module Parsers
      class QaTool
        HOLE_ROW_LENGTH = 18

        attr_reader :csv_contents, :reversed

        def initialize(csv_contents:, reversed: false)
          @csv_contents = csv_contents
          @reversed = reversed
        end

        protected

        def qa_tool
          raise 'Must implement a QA tool'
        end

        def indie_matches
          submatch_pairings.map do |(requester, competitor, submatch_info)|
            if reversed
              apply_tool(competitor, requester, submatch_info)
            else
              apply_tool(requester, competitor, submatch_info)
            end
          end
        end

        def apply_tool(requester, competitor, submatch_info)
          array_offset = -1

          qa_tool.new(
            teebox: teebox_value_from_csv,
            requester: real_scores[requester + array_offset],
            competitor: real_scores[competitor + array_offset],
            submatch: submatch_from(submatch_info)
          ).present
        end

        def team_match
          requester_scores = real_scores[(0..1)]
          competitor_scores = real_scores[(2..3)]

          (requester_scores, competitor_scores = competitor_scores, requester_scores) if reversed

          # remove placeholder 'team'
          _, _, *team_submatch_meta = csv_team_submatch_meta_row
          [
            Matches::Scoring::Presenters::MotherArray.new(
              teebox: teebox_value_from_csv,
              requester: requester_scores,
              competitor: competitor_scores,
              submatch: submatch_from(team_submatch_meta),
              score_array_generator: Matches::Scoring::TeamMatchArray
            ).present.merge(
              junk_score: compute_junk_score(requester_scores, competitor_scores)
            )
          ]
        end

        def teebox_value_from_csv
          Matches::Scoring::Values::Teebox.new(
            hole_handicap_values: csv_hole_handicap_values,
            hole_par_values: []
          )
        end

        def compute_junk_score(requester_team_scores, competitor_team_scores)
          Matches::Scoring::Computations::JunkMatchFinalScore.new(
            requester: requester_team_scores,
            competitor: competitor_team_scores
          ).compute
        end

        def csv_teebox_name
          csv_contents[0][0]
        end

        def csv_hole_par_values
          csv_contents[1].slice(1..HOLE_ROW_LENGTH).map(&:to_i)
        end

        def csv_hole_handicap_values
          csv_contents[2].slice(1..HOLE_ROW_LENGTH).map(&:to_i)
        end

        def csv_match_participants
          csv_contents[3].compact.each_slice(3)
        end

        def csv_indie_submatch_meta
          csv_contents[(10..13)]
        end

        def csv_team_submatch_meta_row
          csv_contents[14]
        end

        def submatch_pairings
          csv_indie_submatch_meta.map do |(requester_position, competitor_position, *submatch_meta)|
            [requester_position.to_i, competitor_position.to_i, submatch_meta]
          end
        end

        def the_participants
          @cached_the_participants ||=
            begin
              csv_match_participants.zip((5..8)).map do |(name, handicap_value, manual_junks), csv_row_number|
                _, *strokes = csv_contents[csv_row_number].map(&:to_i)
                Matches::Scoring::Values::MatchParticipant.new(
                  name: name,
                  handicap_value: handicap_value.to_i,
                  strokes: strokes,
                  manual_junks: manual_junks
                ).esc_adjusted(csv_hole_par_values)
              end
            end
        end

        def real_scores
          @cached_real_scores ||= the_participants.map(&:esc_adjusted)
        end

        def submatch_from(submatch_info)
          Matches::Scoring::Values::Submatch.new(
            match_mode: submatch_info[0],
            match_participation: 'irrelevant',
            aloha_enabled: submatch_info[1],
            aloha_value: submatch_info[2],
            stake: submatch_info[3]
          )
        end
      end
    end
  end
end
# rubocop:enable ClassLength
