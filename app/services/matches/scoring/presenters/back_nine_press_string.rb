module Matches
  module Scoring
    module Presenters
      class BackNinePressString
        attr_reader :submatch, :press_array_final_score

        # submatch - Matches::Scoring::Values::Submatch instance
        # press_array_final_score - Matches::Scoring::PressScoreArray#final_score
        def initialize(submatch:, press_array_final_score:)
          @submatch = submatch
          @press_array_final_score = press_array_final_score
        end

        def present
          [match_mode_string, press_final_score_string, aloha_string].reject(&:empty?).join(' ')
        end

        private

        def match_mode_string
          case submatch.match_mode.to_sym
          when :doubled_back
            '2xB'
          when :seven_way_back
            '7wB'
          when :default
            ''
          end
        end

        def press_final_score_string
          press_array_final_score || ''
        end

        def aloha_string
          if submatch.aloha_enabled
            "#{submatch.aloha_value}wA"
          else
            ''
          end
        end
      end
    end
  end
end
