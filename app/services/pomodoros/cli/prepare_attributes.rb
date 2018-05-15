# frozen_string_literal: true

# Class that handles creating a Pomodoro hash from thor inputs.
# This is because thor always just passes in everything as strings.
# No errors raised yet at this point.
module Pomodoros
  module Cli
    class PrepareAttributes
      extend LightService::Action

      expects :params

      executed do |context|
        payload = context.params.each_with_object({}) do |(key, value), hash|
          hash[key] = attribute_preparations[key].call(value)
        end

        context.params = payload
      end

      def self.attribute_preparations
        {
          description: proc { |attribute| attribute },
          duration: proc { |attribute| attribute.to_i },
          duration_offset: proc { |attribute| attribute.to_i },
          activity_tags: proc { |attribute| attribute }
        }
      end
    end
  end
end
