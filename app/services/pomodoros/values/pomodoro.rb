# frozen_string_literal: true

module Pomodoros
  module Values
    class Pomodoro < Dry::Struct
      constructor_type :strict_with_defaults

      attribute :id, Types::Strict::Int
      attribute :duration, Types::Strict::Int.constrained(gt: 0)
      attribute :description, Types::Strict::String
      attribute :started_at, Types::Strict::Time
      # This should actually be a Set?
      attribute :activity_tags, Types::Array(Pomodoros::Values::ActivityTag).default([])

      def ended_at
        started_at + duration.minutes
      end

      def contains_tag?(tag_name)
        activity_tags.any? { |activity_tag| activity_tag.name == tag_name }
      end
    end
  end
end
