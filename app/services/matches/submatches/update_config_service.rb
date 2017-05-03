module Matches
  module Submatches
    class UpdateConfigService < BaseService
      attr_reader :found_submatch, :attributes

      def initialize(found_submatch:, attributes:)
        @found_submatch = found_submatch
        @attributes = if attributes[:aloha]
                        attributes.merge(aloha: attributes[:aloha].symbolize_keys)
                      else
                        attributes
                      end
      end

      def perform
        found_submatch.update_attributes!(config: found_submatch.config.merge(attributes))
        found_submatch
      end

      def pre_method_hooks
        [
          proc { ensure_required_config_hash_vars_are_present },
          proc { ensure_valid_config_hash }
        ]
      end

      def ensure_required_config_hash_vars_are_present
        missing_attributes = required_attributes.deep_diff(attributes) { |_, v| v.present? }

        if missing_attributes.empty?
          false # false mesns you let the operation continue
        else
          Errors::MissingParams.new(readable_error(missing_attributes))
        end
      end

      def ensure_valid_config_hash
        diff_passed_in = attributes.deep_diff(allowed_attributes) { |first, _| first.nil? }
        diff_allowed = attributes.deep_diff(allowed_attributes) { |_, last| last.nil? }

        excess_attributes = diff_passed_in.deep_diff(diff_allowed)

        if excess_attributes.empty?
          false
        else
          Errors::WrongParams.new(readable_error(excess_attributes))
        end
      end

      private

      def allowed_attributes
        {
          match_mode: Symbol,
          aloha: {
            enabled: TrueClass,
            value: Integer
          }
        }
      end

      def required_attributes
        {
          match_mode: Symbol
        }
      end

      # Just converts the first level of the wrong_attribute hash to something the front-end could understand
      def readable_error(wrong_attributes)
        wrong_attributes.map { |k, v| v.class == Class ? "`#{k}`" : "`#{v.keys.first}` in `#{k}`" }.compact.join(', ')
      end
    end
  end
end
