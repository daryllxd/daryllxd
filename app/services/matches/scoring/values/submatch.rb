module Matches
  module Scoring
    module Values
      class Submatch
        attr_reader :match_mode, :match_participation, :aloha_enabled, :aloha_value, :stake

        def initialize(match_mode:, match_participation:, aloha_enabled:, aloha_value:, stake:)
          @match_mode = match_mode
          @match_participation = match_participation
          @aloha_enabled = parse_aloha_to_boolean(aloha_enabled)
          @aloha_value = aloha_value.to_i
          @stake = stake.to_i
        end

        def parse_aloha_to_boolean(aloha_enabled)
          aloha_enabled == 'aloha_true' ? true : false
        end

        def score_array_generator
          match_participation == 'indie?' ? Matches::Scoring::IndieMatchArray : Matches::Scoring::TeamMatchArray
        end

        def no_alohas
          self.class.new(
            instance_values.symbolize_keys.merge(
              aloha_enabled: false,
              aloha_value: 0
            )
          )
        end
      end
    end
  end
end
