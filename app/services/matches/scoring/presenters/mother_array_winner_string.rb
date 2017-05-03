module Matches
  module Scoring
    module Presenters
      class MotherArrayWinnerString
        include ActionView::Helpers::TextHelper

        attr_reader :mother_array

        def initialize(mother_array:)
          @mother_array = mother_array
        end

        def present
          return 'Match not yet completed' unless mother_array.strokes_completed?

          [
            presented_mother_array[:requester],
            present_win_or_wins,
            present_ways_won,
            present_stake_won
          ].join(' ')
        end

        def present_win_or_wins
          if mother_array.requester.count == 1
            'Wins'
          else
            'Win'
          end
        end

        def present_ways_won
          pluralize(presented_mother_array[:ways_won], 'Ways')
        end

        def present_stake_won
          "+#{presented_mother_array[:ways_won] * presented_mother_array[:stake]}"
        end

        private

        def presented_mother_array
          @cached_presented_mother_array ||=
            begin
              mother_array.ensure_requester_wins.present
            end
        end
      end
    end
  end
end
