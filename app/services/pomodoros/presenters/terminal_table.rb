# frozen_string_literal: true
module Pomodoros
  module Presenters
    # Component class that is the abstraction to terminal table

    class TerminalTable
      attr_reader :title, :headings, :rows

      def initialize(title: 'Table', headings: 'Headings', rows: [])
        @title = title
        @headings = headings
        @rows = rows
      end

      def present
        Terminal::Table.new(table_initializer_params) do |t|
          t.rows = rows
        end
      end

      private

      def table_initializer_params
        {
          title: title,
          headings: headings
        }
      end
    end
  end
end
