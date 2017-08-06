# frozen_string_literal: true
require 'terminal-table'

module Pomodoros
  module Presenters
    class ActivityTags
      attr_reader :activity_tags

      def initialize(activity_tags: ActivityTag.all)
        @activity_tags = activity_tags
      end

      def present
        table = Terminal::Table.new(terminal_table_params) do |t|
          t.rows = presented_activity_tags
        end

        table
      end

      private

      def terminal_table_params
        {
          title: 'All Activity Tags',
          headings: %w(Name Shortcut)
        }
      end

      def presented_activity_tags
        activity_tags.map do |activity_tag|
          [activity_tag.name, activity_tag.shortcut]
        end
      end

      def sorted_tags_for(activity_tag)
        activity_tag.activity_tags.map(&:name).sort.join(', ')
      end
    end
  end
end
