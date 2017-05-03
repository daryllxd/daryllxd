# In: output from Adapters::Matches::SubmatchesAdapter
# Out: updated Submatches
module Matches
  module Submatches
    class MassUpdateService
      attr_reader :submatches

      def initialize(submatches:)
        @submatches = submatches
      end

      def call
        ActiveRecord::Base.transaction do
          submatches.map do |submatch_to_update|
            update_submatch_attributes(submatch_to_update[:submatch], submatch_to_update.except(:submatch))

            update_submatch_config(submatch_to_update[:submatch], submatch_to_update.except(:submatch))

            submatch_to_update[:submatch]
          end
        end
      end

      private

      def update_submatch_attributes(submatch, submatch_attr)
        update_part_of_submatch(
          submatch, updatable_attributes(submatch_attr), Matches::Submatches::UpdateService
        )
      end

      def update_submatch_config(submatch, submatch_attr)
        update_part_of_submatch(
          submatch, config_attributes(submatch_attr), Matches::Submatches::UpdateConfigService
        )
      end

      def update_part_of_submatch(submatch, submatch_attr, update_service)
        # rubocop:disable GuardClause
        if submatch_attr.present?
          update_service.new(
            found_submatch: submatch, attributes: submatch_attr
          ).call
        end
        # rubocop:enable GuardClause
      end

      def updatable_attributes(submatch_attr)
        update_keys = %i(stake)
        submatch_attr.slice(*update_keys)
      end

      def config_attributes(submatch_attr)
        config_keys = %i(match_mode aloha)
        submatch_attr
          .slice(*config_keys)
      end
    end
  end
end
