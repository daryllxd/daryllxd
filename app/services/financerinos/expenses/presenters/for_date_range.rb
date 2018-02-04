# frozen_string_literal: true
require 'terminal-table'

module Financerinos
  module Expenses
    module Presenters
      class ForDateRange
        attr_reader :expenses, :date_range

        def initialize(expenses:, date_range:)
          @expenses = expenses
          @date_range = date_range
        end

        def call
          table = Terminal::Table.new(terminal_table_params) do |t|
            t.rows = presented_expenses
          end

          table << :separator
          table << total_expenses_for_range

          table
        end

        private

        def terminal_table_params
          {
            title: "Today's Expenses",
            headings: %w(Expense Cost Tags)
          }
        end

        def presented_expenses
          expenses.map do |ex|
            [ex.description, ex.amount, tag_for(ex)]
          end
        end

        def total_expenses_for_range
          ['Total expenses:', presented_expenses.sum(&:second), '']
        end

        def tag_for(ex)
          if ex.expense_budget_tags.present?
            ex.expense_budget_tags.map(&:name).sort.join(', ')
          else
            '(None)'
          end
        end
      end
    end
  end
end
