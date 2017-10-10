# frozen_string_literal: true
module Financerinos
  module Expenses
    class CreateService
      extend Memoist

      attr_reader :description, :amount, :tags

      def initialize(description:, amount:, tags: [])
        @description = description
        @amount = amount
        @tags = tags
      end

      def call
        ActiveRecord::Base.transaction do
          create_expense
          create_tags

          if create_expense.valid?
            create_expense
          else
            DaryllxdError.new
          end
        end
      end

      private

      def create_expense
        Expense.create(create_expense_attributes)
      end

      def create_expense_attributes
        {
          description: description,
          amount: amount
        }
      end

      def create_tags
        tags.each do |tag|
          create_expense.expense_budget_tags.create(budget_tag: tag)
        end
      end

      memoize :create_expense
    end
  end
end
