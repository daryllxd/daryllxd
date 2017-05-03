module Matches
  module Scoring
    module Parsers
      class ScenarioAnalysis < QaTool
        def generate
          if csv_contents
            {
              teebox: {
                name: csv_teebox_name,
                par_values: csv_hole_par_values,
                handicap_values:  csv_hole_handicap_values
              },
              participants: the_participants.map(&:to_hash),
              submatches: team_match + indie_matches
            }
          else
            false
          end
        end

        private

        def real_scores
          @cached_real_scores ||=
            begin
              csv_match_participants.zip((5..8)).map do |(name, handicap_value, manual_junks), csv_row_number|
                _, *strokes, _last_stroke = csv_contents[csv_row_number].map(&:to_i)
                Matches::Scoring::Values::MatchParticipant.new(
                  name: name,
                  handicap_value: handicap_value.to_i,
                  strokes: strokes,
                  manual_junks: manual_junks
                )
              end
            end
        end

        def qa_tool
          Matches::Scoring::Presenters::ScenarioAnalysisBeforeLastHole
        end
      end
    end
  end
end
