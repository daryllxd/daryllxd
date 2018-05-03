# frozen_string_literal: true

# Class that handles creating a Pomodoro hash from thor inputs.
# This is because thor always just passes in everything as strings
module Pomodoros
  module Cli
    class PrepareAttributes < BaseService
      attr_reader :attributes

      def initialize(**attributes)
        @attributes = attributes
      end

      def call
        payload = attributes.each_with_object({}) do |(key, value), hash|
          return DaryllxdError.new unless attribute_preparations[key]

          hash[key] = attribute_preparations[key].call(value)
        end

        SuccessfulOperation.new(payload: payload)
      end

      private

      def attribute_preparations
        {
          description: proc { |attribute| attribute },
          duration: proc { |attribute| attribute.to_i },
          duration_offset: proc { |attribute| attribute.to_i }
        }
      end
    end
  end
end
