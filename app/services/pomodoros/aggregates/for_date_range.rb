# frozen_string_literal: true

module Pomodoros
  module Aggregates
    class ForDateRange
      extend Memoist

      attr_reader :date_range

      def initialize(date_range: DateRangeFactory.today)
        @date_range = date_range
      end

      def pomodoro_collection
        Pomodoros::Entities::PomodoroCollection.new(
          pomodoros: pomodoro_entities
        )
      end

      private

      def pomodoro_entities
        pomodoros_from_repository
          .sort_by(&:started_at)
          .reverse
          .map do |p|
          Pomodoros::Entities::Pomodoro.new(
            id: p.id,
            duration: p.duration,
            description: p.description,
            started_at: p.started_at,
            activity_tags: p.activity_tags.map { |at| create_activity_tag(at) }
          )
        end
      end

      def create_activity_tag(at)
        Pomodoros::Entities::ActivityTag.new(
          name: at.name
        )
      end

      def pomodoros_from_repository
        Pomodoros::Queries::ForDateRange.new(
          date_range: date_range
        ).call
      end

      memoize :pomodoro_collection
    end
  end
end
