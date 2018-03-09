# frozen_string_literal: true

module Pomodoros
  module Entities
    class Pomodoro < Dry::Struct
      constructor_type :strict_with_defaults

      attribute :id, Types::Strict::Int
      attribute :duration, Types::Strict::Int.constrained(gt: 0)
      attribute :description, Types::Strict::String
      attribute :started_at, Types::Strict::Time
      # This should actually be a Set?
      attribute :activity_tags, Types::Array(Pomodoros::Entities::ActivityTag).default([])

      SHORTENED_DESCRIPTION_CHARACTER_LIMIT = 28

      def shortened_description
        if description.length > SHORTENED_DESCRIPTION_CHARACTER_LIMIT
          description.first(SHORTENED_DESCRIPTION_CHARACTER_LIMIT) + '…'
        else
          description
        end
      end

      def ended_at
        started_at + duration.minutes
      end

      def contains_tag?(tag_name)
        activity_tags.any? { |activity_tag| activity_tag.name == tag_name }
      end
    end
  end
end
