module Matches
  module Scoring
    module Values
      class MatchParticipant
        attr_reader :handicap_value, :strokes, :id, :name, :manual_junks, :hole_par_values

        # rubocop:disable ParameterLists
        def initialize(id: nil, name: nil, handicap_value:, manual_junks: 0, strokes:, hole_par_values: [])
          @handicap_value = handicap_value
          @strokes = strokes
          @name = name
          @id = id
          @manual_junks = manual_junks.to_i
          @hole_par_values = hole_par_values
        end
        # rubocop:enable ParameterLists

        def completed_strokes?
          strokes.compact.length == 18
        end

        def esc_adjusted(hole_par_values)
          self.class.new(
            id: id,
            handicap_value: handicap_value,
            name: name,
            strokes: Matches::Scoring::EscGrossScoreArray.new(
              match_participant: match_participant_object,
              hole_par_values: hole_par_values
            ).presented_score_array,
            manual_junks: manual_junks,
            hole_par_values: hole_par_values
          )
        end

        def without_last_hole
          for_hole_range(hole_range_object: HoleRange.new(:first_seventeen))
        end

        def for_hole_range(hole_range_object: HoleRange.new(:overall))
          return self if hole_range_object.overall?

          self.class.new(
            instance_values.symbolize_keys.merge(strokes: strokes[hole_range_object.to_range_adjusted_for_zero_index])
          )
        end

        def to_hash
          {
            id: id,
            name: name,
            handicap_value: handicap_value,
            raw_gross_score: strokes,
            final_score: strokes.map(&:to_i).sum,
            manual_junks: manual_junks
          }
        end

        # Functional -- create a new instance of yourself but appedn the stroke value to the end of the current strokes
        def append_to_strokes(stroke_value)
          self.class.new(
            instance_values.symbolize_keys.merge(strokes: strokes + [stroke_value])
          )
        end

        private

        def match_participant_object
          self.class.new(
            id: id,
            name: name,
            handicap_value: handicap_value,
            strokes: strokes,
            manual_junks: manual_junks
          )
        end
      end
    end
  end
end
