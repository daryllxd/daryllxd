# frozen_string_literal: true

module Pomodoros
  module Values
    class Pomodoro < Dry::Struct
      attribute :id, Types::Strict::Int
      attribute :duration, Types::Strict::Int.constrained(gt: 0)
      attribute :description, Types::Strict::String
      attribute :started_at, Types::Strict::Time

      def ended_at
        started_at + duration.minutes
      end
    end
  end
end
