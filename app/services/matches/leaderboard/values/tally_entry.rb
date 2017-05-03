module Matches
  module Leaderboard
    module Values
      class TallyEntry < BaseTally
        def self.null_tally_entry
          new(wins: 0, ties: 0, losses: 0, units: 0, submatch_type: nil)
        end

        attr_reader :submatch_type

        def initialize(submatch_type:, **context)
          super(allowed_context(context))
          @submatch_type = submatch_type
        end

        def indie?
          submatch_type == 'indie'
        end

        def team?
          submatch_type == 'team'
        end

        private

        def base_tally_constructor_keys
          [:wins, :ties, :losses, :units]
        end

        def allowed_context(context)
          context.slice(*base_tally_constructor_keys)
        end
      end
    end
  end
end
