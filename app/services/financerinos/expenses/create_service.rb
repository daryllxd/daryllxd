# frozen_string_literal: true
module Financerinos
  module Expenses
    class CreateService
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

          return DaryllxdError.new unless created_expense.valid?
          return created_expense
        end
      end

      private

      def create_expense
        @memoized_created_expense ||= Expense.create(create_expense_attributes)
      end

      def create_expense_attributes
        {
          description: description,
          amount: amount
        }
      end

      def create_tags
        tags.each do |tag|
          created_expense.expense_budget_tags.create(budget_tag: tag)
        end
      end

      def created_expense
        @memoized_created_expense
      end
    end
  end
end
