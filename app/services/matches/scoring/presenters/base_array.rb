module Matches
  module Scoring
    module Presenters
      class BaseArray
        attr_reader :teebox, :requester, :competitor, :submatch, :score_array_generator

        def initialize(
          requester:, competitor:,
          submatch:, teebox:,
          score_array_generator: Matches::Scoring::IndieMatchArray
        )

          @requester = Array(requester)
          @competitor = Array(competitor)
          @submatch = submatch
          @teebox = teebox
          @score_array_generator = score_array_generator
        end

        def generate_names(participants)
          Array(participants).map(&:name).join('/')
        end

        def generate_ids(participants)
          Array(participants).map(&:id)
        end

        protected

        def context
          Struct.new(*instance_values.keys.map(&:to_sym)).new(*instance_values.values)
        end
      end
    end
  end
end
