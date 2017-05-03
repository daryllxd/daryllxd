module Matches
  module Submatches
    class UpdateService < BaseService
      attr_reader :found_submatch, :attributes

      def initialize(found_submatch:, attributes:)
        @found_submatch = found_submatch
        @attributes = attributes
      end

      def perform
        found_submatch.update_attributes(attributes)

        if found_submatch.valid?
          found_submatch
        else
          record_invalid_error_from(found_submatch)
        end
      end

      def pre_method_hooks
        [proc { ensure_no_excess_attributes }]
      end

      private

      def editable_attributes
        %i(stake)
      end
    end
  end
end
