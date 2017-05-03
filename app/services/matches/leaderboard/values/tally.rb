module Matches
  module Leaderboard
    module Values
      class Tally < BaseTally
        include ActionView::Helpers::NumberHelper
        include Comparable

        def percentage
          convert_to_percentage(percentage_numerator / percentage_denominator * 100)
        end

        def presented_units
          if units.positive?
            "+#{units}"
          elsif units.negative?
            units.to_s
          elsif units.zero?
            'E'
          else
            raise 'Units is not a number'
          end
        end

        def total_matches
          (wins + losses + ties).to_i
        end

        def win_loss_tie_record
          add_ties = ties.nonzero? ? [ties] : []
          ([wins, losses] + add_ties).map(&:to_i).join('-')
        end

        def <=>(other)
          other.units <=> units
        end

        private

        def percentage_numerator
          wins + (ties / 2)
        end

        def percentage_denominator
          wins + ties + losses
        end

        def convert_to_percentage(number)
          number_to_percentage(number, precision: 0)
        end
      end
    end
  end
end
