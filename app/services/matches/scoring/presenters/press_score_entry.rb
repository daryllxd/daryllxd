module Matches
  module Scoring
    module Presenters
      class PressScoreEntry
        attr_reader :score

        def initialize(score:)
          @score = score
        end

        def present
          return nil unless score

          if display_as_name?
            present_text(score.first)
          else
            score.map(&:abs).join('/')
          end
        end

        private

        def present_text(score)
          if score.positive?
            "#{score} UP"
          elsif score.negative?
            "#{score.abs} DN"
          else
            'EVEN'
          end
        end

        def display_as_name?
          no_press_yet?
        end

        def no_press_yet?
          !score.many?
        end
      end
    end
  end
end
