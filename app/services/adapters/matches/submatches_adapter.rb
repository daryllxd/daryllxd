module Adapters
  module Matches
    AdaptedSubmatch = Struct.new(:match, :submatches) do
      def valid?
        true
      end
    end

    class SubmatchesAdapter < Adapters::BaseControllerAdapter
      attr_reader :params, :match

      def initialize(params:)
        @params = params
      end

      def perform
        AdaptedSubmatch.new(match, submatches_hash)
      end

      private

      def pre_method_hooks
        [
          proc { ensure_found_match },
          proc { ensure_all_submatches_are_found }
        ]
      end

      def ensure_found_match
        @match = Match.find_by(id: params[:id])

        Errors::ObjectNotFound.new(finder_class: Match) unless @match
      end

      def ensure_all_submatches_are_found
        Errors::ObjectNotFound.new(finder_class: Submatch) unless all_submatches_were_found?
      end

      def all_submatches_were_found?
        submatches_hash.all? { |submatch| submatch[:submatch].present? }
      end

      def submatches_hash
        @cached_submatches_hash ||=
          begin
            if params[:submatches]
              params[:submatches].map do |submatch_hash|
                submatch_hash
                  .symbolize_keys
                  .deep_dup
                  .merge(submatch: match.submatches.find { |x| x.id == submatch_hash[:id].to_i })
                  .reject { |key| key == :id }
              end
            else
              match.submatches.map { |submatch| { submatch: submatch } }
            end
          end
      end
    end
  end
end
